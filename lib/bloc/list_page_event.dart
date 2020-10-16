part of 'list_page_bloc.dart';

abstract class ListPageEvent {
  factory ListPageEvent.tryLoadNextPage() => _LoadNextPageEvent();
}

class _LoadNextPageEvent implements ListPageEvent {}
