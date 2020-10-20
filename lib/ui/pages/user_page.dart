import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/bloc/user_page/user_page_bloc.dart';
import 'package:htd_poc/model/user.dart';
import 'package:htd_poc/ui/widgets/favorite_indicator.dart';

class UserPage extends StatelessWidget {
  final int userId;

  const UserPage({Key key, @required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserPageBloc>(
      create: (_) => UserPageBloc()..add(UserPageEvent.loadUser(userId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Profile"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 4.0),
          child: BlocBuilder<UserPageBloc, UserPageState>(
            builder: (BuildContext context, UserPageState state) {
              if (state.user != null) {
                return _UserInfo(user: state.user);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
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
    return Row(
      children: [
        Expanded(
            child: Column(
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
        )),
        FavoriteIndicator(
          userId: user.id,
          clickable: true,
          iconSize: 48.0,
        ),
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
