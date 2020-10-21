part of 'post_list_page_bloc.dart';

class PostListPageState {
  final bool canFetchMore;
  final List<Post> loadedPosts;
  final List<Filter<Post>> activeFilters;

  PostListPageState._(this.canFetchMore, this.loadedPosts, this.activeFilters);

  factory PostListPageState.initial() => PostListPageState._(true, [], []);

  PostListPageState withNewElements(List<Post> newPosts) => PostListPageState._(
        newPosts.length >= _postsPerPage,
        loadedPosts..addAll(newPosts),
        activeFilters,
      );

  PostListPageState withFilters(
          List<Post> filteredList, List<Filter<Post>> activeFilters) =>
      PostListPageState._(canFetchMore, filteredList, activeFilters);

  bool get loaded => loadedPosts.isNotEmpty;

  bool isFilterOfTypeActive<T>() =>
      activeFilters.firstWhere((Filter<Post> filter) => filter is T,
          orElse: () => null) !=
      null;
}
