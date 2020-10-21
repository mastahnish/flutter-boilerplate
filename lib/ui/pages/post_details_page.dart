import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/bloc/user/user_bloc.dart';
import 'package:htd_poc/model/post.dart';
import 'package:htd_poc/model/user.dart';
import 'package:htd_poc/ui/widgets/post_widget.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;
  final int userId;

  const PostDetailsPage({Key key, @required this.post, @required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (_) => UserBloc()..add(UserEvent.loadUser(userId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            children: [
              PostWidget(post: post, detailsMode: true),
              BlocBuilder<UserBloc, UserState>(
                builder: (BuildContext context, UserState state) {
                  if (state.user != null) {
                    return _UserInfo(user: state.user);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final User user;

  const _UserInfo({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.only(),
          children: [
            _ProfileHeader(user: user),
            const SizedBox(height: 8.0),
            _ProfileBody(user: user),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            user.name,
            style: theme.primaryTextTheme.headline4
                .copyWith(fontWeight: FontWeight.w400),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            '@${user.username}',
            style: theme.primaryTextTheme.headline6.copyWith(
                fontWeight: FontWeight.w300, color: theme.accentColor),
          ),
        )
      ],
    );
  }
}

class _ProfileBody extends StatelessWidget {
  final User user;

  const _ProfileBody({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      color: theme.cardColor.withOpacity(0.6),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileEntry(label: 'phone', value: user.phone),
            _ProfileEntry(label: 'e-mail', value: user.email),
            _ProfileEntry(label: 'website', value: user.website),
            _ProfileEntry(label: 'address', value: user.address.toString()),
            _ProfileEntry(label: 'company', value: user.company.name),
          ],
        ),
      ),
    );
  }
}

class _ProfileEntry extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileEntry({Key key, @required this.label, @required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(text: '$label: ', style: theme.primaryTextTheme.bodyText2),
          TextSpan(
              text: value,
              style: theme.primaryTextTheme.bodyText1
                  .copyWith(fontWeight: FontWeight.w900)),
        ]),
      ),
    );
  }
}
