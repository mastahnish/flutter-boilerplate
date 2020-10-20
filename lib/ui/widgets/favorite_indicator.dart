import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/bloc/favorites/favorites_bloc.dart';

class FavoriteIndicator extends StatelessWidget {
  final int userId;

  final bool showAsButton;
  final double iconSize;

  const FavoriteIndicator(
      {Key key,
      @required this.userId,
      this.showAsButton = false,
      this.iconSize = 24.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (BuildContext context, FavoritesState state) {
      final bool isFavorite = state.favoriteUsers.contains(userId);
      if (showAsButton) {
        return IconButton(
          icon: Icon(isFavorite
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded),
          color: isFavorite ? theme.accentColor : theme.dividerColor,
          onPressed: () =>
              context.bloc<FavoritesBloc>().add(FavoritesEvent.toggle(userId)),
          iconSize: iconSize,
        );
      }
      if (isFavorite) {
        return Icon(
          Icons.favorite_rounded,
          size: iconSize,
          color: theme.accentColor,
        );
      }
      return const SizedBox();
    });
  }
}
