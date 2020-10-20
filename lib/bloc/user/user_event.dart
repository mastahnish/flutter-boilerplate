part of 'user_bloc.dart';

abstract class UserEvent {
  factory UserEvent.loadUser(int id) => _LoadUserEvent(id);
}

class _LoadUserEvent implements UserEvent {
  final int id;

  _LoadUserEvent(this.id);
}
