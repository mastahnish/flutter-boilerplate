import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FavoriteIndicator extends StatelessWidget {
  final int userId;

  final bool clickable;
  final double iconSize;

  const FavoriteIndicator(
      {Key key,
      @required this.userId,
      this.clickable = false,
      this.iconSize = 24.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite_border_rounded),
      onPressed: () {},
      iconSize: iconSize,
    );
  }
}
