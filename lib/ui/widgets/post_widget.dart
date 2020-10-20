import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/bloc/favorites/favorites_bloc.dart';
import 'package:htd_poc/bloc/user/user_bloc.dart';
import 'package:htd_poc/model/post.dart';
import 'package:htd_poc/ui/pages/post_details_page.dart';
import 'package:htd_poc/ui/widgets/favorite_indicator.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final bool detailsMode;

  const PostWidget({Key key, @required this.post, this.detailsMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget postBody = _PostBody(post: post, detailsMode: detailsMode);
    return detailsMode
        ? postBody
        : InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.bloc<FavoritesBloc>(),
                  child: PostDetailsPage(userId: post.userId, post: post),
                ),
              ),
            ),
            child: postBody,
          );
  }
}

class _PostBody extends StatelessWidget {
  final Post post;
  final bool detailsMode;

  const _PostBody({Key key, @required this.post, this.detailsMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        post.title,
                        style: theme.primaryTextTheme.headline6
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    if (detailsMode)
                      FavoriteIndicator(
                        postId: post.id,
                        showAsButton: true,
                        iconSize: 48.0,
                      ),
                  ],
                ),
                const SizedBox(height: 4.0),
                RichText(
                  text: TextSpan(
                    text: post.body,
                    style: theme.primaryTextTheme.bodyText1
                        .copyWith(fontWeight: FontWeight.w200),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!detailsMode) _Footer(userId: post.userId, postId: post.id),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final int userId;
  final int postId;

  const _Footer({Key key, @required this.userId, @required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FavoriteIndicator(postId: postId, iconSize: 14.0),
          BlocProvider<UserBloc>(
              create: (_) => UserBloc()..add(UserEvent.loadUser(userId)),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (BuildContext context, UserState state) {
                  final TextStyle style = theme.accentTextTheme.subtitle2
                      .copyWith(
                          color: theme.accentColor,
                          fontWeight: FontWeight.w300);
                  return state.user != null
                      ? Text('@${state.user.username}', style: style)
                      : Text('loading...', style: style);
                },
              )),
        ],
      ),
    );
  }
}
