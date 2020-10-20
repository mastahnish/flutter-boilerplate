import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/main.dart';
import 'package:htd_poc/services/favorites_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository _favoritesRepository = locator.get();

  FavoritesBloc() : super(FavoritesState.initial());

  @override
  Stream<FavoritesState> mapEventToState(FavoritesEvent event) async* {
    if (event is _ToggleFavorite) {
      _favoritesRepository.setStatus(userId: event.userId);
      final Set<int> favoriteUsers = _favoritesRepository.favorites;
      yield state.modified(favoriteUsers);
    }
  }
}
