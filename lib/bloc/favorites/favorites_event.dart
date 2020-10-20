part of 'favorites_bloc.dart';

abstract class FavoritesEvent {
  factory FavoritesEvent.toggle(int userId) => _ToggleFavorite(userId);
}

class _ToggleFavorite implements FavoritesEvent {
  final int postId;

  _ToggleFavorite(this.postId);
}
