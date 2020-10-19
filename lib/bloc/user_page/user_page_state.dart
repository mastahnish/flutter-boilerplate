part of 'user_page_bloc.dart';

class UserPageState {
  final User user;

  UserPageState._(this.user);

  factory UserPageState.initial() => UserPageState._(null);
  factory UserPageState.loaded(User user) => UserPageState._(user);
}
