import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/bloc/user_page/user_page_bloc.dart';
import 'package:htd_poc/model/post.dart';
import 'package:htd_poc/ui/pages/user_page.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) => UserPage(userId: post.userId)),
      ),
      child: _PostBody(post: post),
    );
  }
}

class _PostBody extends StatelessWidget {
  final Post post;

  const _PostBody({Key key, @required this.post}) : super(key: key);

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
                Text(
                  post.title,
                  style: theme.primaryTextTheme.headline6
                      .copyWith(fontWeight: FontWeight.w500),
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
        _UserHandle(userId: post.userId),
      ],
    );
  }
}

class _UserHandle extends StatelessWidget {
  final int userId;

  const _UserHandle({Key key, @required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(right: 4.0),
      alignment: Alignment.topRight,
      child: BlocProvider<UserPageBloc>(
          create: (_) => UserPageBloc()..add(UserPageEvent.loadUser(userId)),
          child: BlocBuilder<UserPageBloc, UserPageState>(
            builder: (BuildContext context, UserPageState state) {
              final TextStyle style = theme.accentTextTheme.subtitle2
                  .copyWith(color: theme.accentColor);
              return state.user != null
                  ? Text('@${state.user.username}', style: style)
                  : Text('loading...', style: style);
            },
          )),
    );
  }
}
