part of 'user_page_bloc.dart';

abstract class UserPageEvent {
  factory UserPageEvent.loadUser(int id) => _LoadUserEvent(id);
}

class _LoadUserEvent implements UserPageEvent {
  final int id;

  _LoadUserEvent(this.id);
}
