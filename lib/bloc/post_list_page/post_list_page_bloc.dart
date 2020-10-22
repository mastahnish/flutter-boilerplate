import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/main.dart';
import 'package:htd_poc/misc/filter.dart';
import 'package:htd_poc/model/post.dart';
import 'package:htd_poc/services/favorites_repository.dart';
import 'package:htd_poc/services/posts_repository.dart';

part 'post_list_page_event.dart';
part 'post_list_page_state.dart';

const _postsPerPage = 5;

class PostListPageBloc extends Bloc<PostListPageEvent, PostListPageState> {
  final PostsRepository _postsRepository = locator.get();
  final FavoritesRepository _favoritesRepository = locator.get();

  PostListPageBloc() : super(PostListPageState.initial());

  @override
  Stream<PostListPageState> mapEventToState(PostListPageEvent event) async* {
    if (event is _LoadNextPageEvent) {
      if (state.canFetchMore) {
        final List<Post> loadedPosts = state.loadedPosts.isEmpty &&
                    _postsRepository.cachedPostsCount == 0 ||
                state.loadedPosts.isNotEmpty
            ? await _postsRepository.fetchNewPosts(_postsPerPage)
            : _postsRepository.cachedPosts;
        yield state
            .withNewElements(applyFilters(loadedPosts, state.activeFilters));
      }
    } else if (event is _SetFavoritesFilter) {
      if (event.active) {
        yield _handleActivateFilterEvent<FavoritesFilter>(
            FavoritesFilter(_favoritesRepository));
      } else {
        yield _handleDeactivateFilterEvent<FavoritesFilter>();
      }
    } else if (event is _SetQueryFilter) {
      if (event.query.isNotEmpty) {
        yield _handleActivateFilterEvent<QueryFilter>(QueryFilter(event.query));
      } else {
        yield _handleDeactivateFilterEvent<QueryFilter>();
      }
    }
  }

  PostListPageState _handleActivateFilterEvent<T>(
      Filter<Post> newFilterInstance) {
    if (!state.isFilterOfTypeActive<T>()) {
      final List<Filter<Post>> updatedFilters = [...state.activeFilters]
        ..add(newFilterInstance);
      return state.withFilters(
          applyFilters(_postsRepository.cachedPosts, updatedFilters),
          updatedFilters);
    }
    return state;
  }

  PostListPageState _handleDeactivateFilterEvent<T>() {
    final List<Filter<Post>> updatedFilters = [...state.activeFilters]
      ..removeWhere((Filter<Post> filter) => filter is T);
    return state.withFilters(
        applyFilters(_postsRepository.cachedPosts, updatedFilters),
        updatedFilters);
  }
}
