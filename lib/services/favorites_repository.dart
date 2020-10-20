import 'package:flutter/foundation.dart';

class FavoritesRepository {
  final Set<int> _favoriteUsers = {};

  Set<int> get favorites => {..._favoriteUsers};

  void setStatus({@required int userId}) {
    if (_favoriteUsers.contains(userId)) {
      _favoriteUsers.remove(userId);
    } else {
      _favoriteUsers.add(userId);
    }
  }
}
