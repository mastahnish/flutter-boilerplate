part of 'post_list_page_bloc.dart';

abstract class PostListPageEvent {
  factory PostListPageEvent.tryLoadNextPage() => _LoadNextPageEvent();
}

class _LoadNextPageEvent implements PostListPageEvent {}
