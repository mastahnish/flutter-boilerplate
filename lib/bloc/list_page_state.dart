part of 'list_page_bloc.dart';

class ListPageState {
  final int pagesLoaded;
  final List<ListElementModel> loadedElements;

  ListPageState._(this.pagesLoaded, this.loadedElements);

  factory ListPageState.initial() => ListPageState._(0, const []);

  ListPageState withNewElements(List<ListElementModel> newElements) =>
      ListPageState._(pagesLoaded + 1, [...loadedElements, ...newElements]);

  bool get loaded => loadedElements.isNotEmpty;
}
