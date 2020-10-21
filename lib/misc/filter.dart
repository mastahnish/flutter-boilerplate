import 'package:htd_poc/model/post.dart';
import 'package:htd_poc/services/favorites_repository.dart';

List<T> applyFilters<T>(List<T> inputList, List<Filter<T>> filters) {
  List<T> output = inputList;
  for (Filter<T> filter in filters) {
    output = filter.apply(output);
  }
  return output;
}

abstract class Filter<T> {
  List<T> apply(List<T> input);
}

class FavoritesFilter implements Filter<Post> {
  final FavoritesRepository _favoritesRepository;

  FavoritesFilter(this._favoritesRepository);

  @override
  List<Post> apply(List<Post> input) => input
      .where((Post post) => _favoritesRepository.isFavorite(post.id))
      .toList();
}

class QueryFilter implements Filter<Post> {
  final String query;

  QueryFilter(this.query);

  @override
  List<Post> apply(List<Post> input) => input
      .where((Post post) =>
          post.title.contains(query) || post.body.contains(query))
      .toList();
}
