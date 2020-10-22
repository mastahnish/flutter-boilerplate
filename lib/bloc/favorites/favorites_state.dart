part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  final Set<int> favoritePosts;

  FavoritesState._(this.favoritePosts);

  factory FavoritesState.initial() => FavoritesState._({});
  FavoritesState modified(Set<int> favoriteUsers) =>
      FavoritesState._(favoriteUsers);

  @override
  List<Object> get props => [favoritePosts];
}
