import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/model/user.dart';
import 'package:htd_poc/services/users_repository.dart';

part 'user_page_event.dart';
part 'user_page_state.dart';

class UserPageBloc extends Bloc<UserPageEvent, UserPageState> {
  final UsersRepository _usersRepository = UsersRepository();

  UserPageBloc() : super(UserPageState.initial());

  @override
  Stream<UserPageState> mapEventToState(UserPageEvent event) async* {
    if (event is _LoadUserEvent) {
      final User user = await _usersRepository.fetchUser(event.id);
      yield UserPageState.loaded(user);
    }
  }
}
