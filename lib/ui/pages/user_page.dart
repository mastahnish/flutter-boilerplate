import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/bloc/user_page/user_page_bloc.dart';

class UserPage extends StatelessWidget {
  final int userId;

  const UserPage({Key key, @required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserPageBloc>(
      create: (_) => UserPageBloc()..add(UserPageEvent.loadUser(userId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: BlocBuilder<UserPageBloc, UserPageState>(
          builder: (BuildContext context, UserPageState state) {
            if (state.user != null) {
              return Text(state.user.name);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
