part of 'user_bloc.dart';

class UserState {
  final User user;

  UserState._(this.user);

  factory UserState.initial() => UserState._(null);
  factory UserState.loaded(User user) => UserState._(user);
}
