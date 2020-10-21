part of 'post_list_page_bloc.dart';

abstract class PostListPageEvent {
  factory PostListPageEvent.tryLoadNextPage() => _LoadNextPageEvent();
  factory PostListPageEvent.setFavoritesFilter({@required bool active}) =>
      _SetFavoritesFilter(active);
  factory PostListPageEvent.setQueryFilter({@required String query}) =>
      _SetQueryFilter(query);
}

class _LoadNextPageEvent implements PostListPageEvent {}

class _SetFavoritesFilter implements PostListPageEvent {
  final bool active;

  _SetFavoritesFilter(this.active);
}

class _SetQueryFilter implements PostListPageEvent {
  final String query;

  _SetQueryFilter(this.query);
}
