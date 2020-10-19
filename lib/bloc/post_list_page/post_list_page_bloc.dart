import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/model/post.dart';
import 'package:htd_poc/services/posts_repository.dart';

part 'post_list_page_event.dart';
part 'post_list_page_state.dart';

const _postsPerPage = 5;

class PostListPageBloc extends Bloc<PostListPageEvent, PostListPageState> {
  final PostsRepository _postsRepository = PostsRepository();

  PostListPageBloc() : super(PostListPageState.initial()) {
    this.add(PostListPageEvent.tryLoadNextPage());
  }

  @override
  Stream<PostListPageState> mapEventToState(PostListPageEvent event) async* {
    if (event is _LoadNextPageEvent) {
      if (state.canFetchMore) {
        final List<Post> loadedPosts = state.loadedPosts.isEmpty &&
                    _postsRepository.cachedPostsCount == 0 ||
                state.loadedPosts.isNotEmpty
            ? await _postsRepository.fetchNewPosts(_postsPerPage)
            : _postsRepository.cachedPosts;
        yield state.withNewElements(loadedPosts);
      }
    }
  }
}
