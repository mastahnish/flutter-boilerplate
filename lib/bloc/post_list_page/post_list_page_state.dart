part of 'post_list_page_bloc.dart';

class PostListPageState {
  final bool canFetchMore;
  final List<Post> loadedPosts;

  PostListPageState._(this.canFetchMore, this.loadedPosts);

  factory PostListPageState.initial() => PostListPageState._(true, []);

  PostListPageState withNewElements(List<Post> newPosts) => PostListPageState._(
      newPosts.length >= _postsPerPage, loadedPosts..addAll(newPosts));

  bool get loaded => loadedPosts.isNotEmpty;
}
