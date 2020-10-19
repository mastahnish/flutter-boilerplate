import 'dart:convert';

import 'package:htd_poc/model/post.dart';
import 'package:http/http.dart';

class PostsRepository {
  static const _apiUrl = "http://jsonplaceholder.typicode.com";

  final List<Post> _cachedPosts = [];

  List<Post> get cachedPosts => [..._cachedPosts];
  int get cachedPostsCount => _cachedPosts.length;

  Future<List<Post>> fetchNewPosts(int count) async {
    final int cacheSize = _cachedPosts.length;
    final List<Future<Post>> requests = [];
    for (int i = 0; i < count; i++) {
      final Future<Post> request = _fetchSinglePost(cacheSize + i + 1);
      requests.add(request);
    }
    final List<Post> newPosts = await Future.wait(requests);
    newPosts.removeWhere((Post post) => post == null);
    _cachedPosts.addAll(newPosts);
    return newPosts;
  }

  Future<Post> _fetchSinglePost(int id) async {
    return get("$_apiUrl/posts/$id").then((Response response) {
      if (response.statusCode == 200) {
        final Map jsonResponse = jsonDecode(response.body);
        return jsonResponse.isNotEmpty ? Post.fromJson(jsonResponse) : null;
      } else {
        throw "request error";
      }
    });
  }
}
