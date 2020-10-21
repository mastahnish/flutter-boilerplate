import 'package:flutter/foundation.dart';

class FavoritesRepository {
  final Set<int> _favoritePosts = {};

  Set<int> get favorites => {..._favoritePosts};

  bool isFavorite(int postId) => _favoritePosts.contains(postId);

  void setStatus({@required int postId}) {
    if (_favoritePosts.contains(postId)) {
      _favoritePosts.remove(postId);
    } else {
      _favoritePosts.add(postId);
    }
  }
}
