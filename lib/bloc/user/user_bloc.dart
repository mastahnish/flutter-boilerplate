import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/model/user.dart';
import 'package:htd_poc/services/users_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository _usersRepository = UsersRepository();

  UserBloc() : super(UserState.initial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is _LoadUserEvent) {
      final User user = await _usersRepository.fetchUser(event.id);
      yield UserState.loaded(user);
    }
  }
}
