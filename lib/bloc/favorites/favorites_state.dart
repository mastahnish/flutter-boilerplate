part of 'favorites_bloc.dart';

class FavoritesState {
  final Set<int> favoriteUsers;

  FavoritesState._(this.favoriteUsers);

  factory FavoritesState.initial() => FavoritesState._({});
  FavoritesState modified(Set<int> favoriteUsers) =>
      FavoritesState._(favoriteUsers);
}
