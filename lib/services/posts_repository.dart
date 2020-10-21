import 'package:htd_poc/main.dart';
import 'package:htd_poc/model/post.dart';
import 'package:htd_poc/services/api_service.dart';

class PostsRepository {
  final ApiService _apiService = locator.get();

  final List<Post> _cachedPosts = [];

  List<Post> get cachedPosts => [..._cachedPosts];
  int get cachedPostsCount => _cachedPosts.length;

  Future<List<Post>> fetchNewPosts(int count) async {
    final int cacheSize = _cachedPosts.length;
    final List<Future<Post>> requests = [];
    for (int i = 0; i < count; i++) {
      final Future<Post> request =
          _apiService.fetchSinglePost(cacheSize + i + 1);
      requests.add(request);
    }
    final List<Post> newPosts = await Future.wait(requests);
    newPosts.removeWhere((Post post) => post == null);
    _cachedPosts.addAll(newPosts);
    return newPosts;
  }
}
