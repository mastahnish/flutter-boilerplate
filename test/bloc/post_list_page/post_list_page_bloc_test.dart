import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:htd_poc/bloc/post_list_page/post_list_page_bloc.dart';
import 'package:htd_poc/main.dart';
import 'package:htd_poc/misc/filter.dart';
import 'package:htd_poc/model/post.dart';
import 'package:htd_poc/services/favorites_repository.dart';
import 'package:htd_poc/services/posts_repository.dart';
import 'package:mockito/mockito.dart';

class PostsRepositoryMock extends Mock implements PostsRepository {}

class FavoritesRepositoryMock extends Mock implements FavoritesRepository {}

void main() {
  PostsRepository postsRepositoryMock;
  FavoritesRepository favoritesRepositoryMock;

  final List<Post> mockPosts = [
    Post(1, 1, '1', '1'),
    Post(2, 2, '2', '2'),
    Post(3, 3, '3', '3'),
    Post(4, 4, '4', '4'),
    Post(5, 5, '5', '5'),
  ];

  final List<Filter<Post>> mockFilters = [];

  setUp(() {
    postsRepositoryMock = PostsRepositoryMock();
    favoritesRepositoryMock = FavoritesRepositoryMock();

    locator.registerSingleton<PostsRepository>(postsRepositoryMock);
    locator.registerSingleton<FavoritesRepository>(favoritesRepositoryMock);
  });

  tearDown(() {
    locator.reset();
    mockFilters.clear();
  });

  blocTest(
    'should load first page',
    build: () {
      when(postsRepositoryMock.cachedPostsCount).thenReturn(0);
      when(postsRepositoryMock.fetchNewPosts(any))
          .thenAnswer((_) async => mockPosts);

      return PostListPageBloc();
    },
    act: (PostListPageBloc bloc) {
      bloc.add(PostListPageEvent.tryLoadNextPage());
    },
    expect: [
      PostListPageState.initial().withNewElements(mockPosts),
    ],
  );

  blocTest(
    'should load two pages',
    build: () {
      when(postsRepositoryMock.cachedPostsCount).thenReturn(0);
      when(postsRepositoryMock.fetchNewPosts(any))
          .thenAnswer((_) async => mockPosts);

      return PostListPageBloc();
    },
    act: (PostListPageBloc bloc) {
      bloc.add(PostListPageEvent.tryLoadNextPage());
      bloc.add(PostListPageEvent.tryLoadNextPage());
    },
    expect: [
      PostListPageState.initial().withNewElements(mockPosts),
      PostListPageState.initial()
          .withNewElements(mockPosts)
          .withNewElements(mockPosts),
    ],
  );

  blocTest(
    'should load two pages where the second page is the last available one',
    build: () {
      when(postsRepositoryMock.cachedPostsCount).thenReturn(0);
      bool loadedFirstPage = false;
      when(postsRepositoryMock.fetchNewPosts(any)).thenAnswer(
        (_) async {
          final List<Post> posts =
              mockPosts.sublist(0, loadedFirstPage ? 3 : mockPosts.length);
          if (!loadedFirstPage) {
            loadedFirstPage = true;
          }
          return posts;
        },
      );

      return PostListPageBloc();
    },
    act: (PostListPageBloc bloc) {
      bloc.add(PostListPageEvent.tryLoadNextPage());
      bloc.add(PostListPageEvent.tryLoadNextPage());
    },
    expect: [
      PostListPageState.initial().withNewElements(mockPosts),
      PostListPageState.initial()
          .withNewElements(mockPosts)
          .withNewElements(mockPosts.sublist(0, 3)),
    ],
  );

  blocTest(
    'should load no elements with favorites filter',
    build: () {
      mockFilters.add(FavoritesFilter(favoritesRepositoryMock));

      when(postsRepositoryMock.cachedPostsCount).thenReturn(0);
      when(postsRepositoryMock.cachedPosts).thenReturn(mockPosts);
      when(postsRepositoryMock.fetchNewPosts(any))
          .thenAnswer((_) async => mockPosts);
      when(favoritesRepositoryMock.isFavorite(any)).thenReturn(false);

      return PostListPageBloc();
    },
    act: (PostListPageBloc bloc) {
      bloc.add(PostListPageEvent.tryLoadNextPage());
      bloc.add(PostListPageEvent.setFavoritesFilter(active: true));
      bloc.add(PostListPageEvent.setFavoritesFilter(active: false));
    },
    expect: [
      PostListPageState.initial().withNewElements(mockPosts),
      PostListPageState.initial()
          .withNewElements(mockPosts)
          .withFilters([], mockFilters),
      PostListPageState.initial().withNewElements(mockPosts),
    ],
  );

  blocTest(
    'should load one element with favorites filter',
    build: () {
      mockFilters.add(FavoritesFilter(favoritesRepositoryMock));

      when(postsRepositoryMock.cachedPostsCount).thenReturn(0);
      when(postsRepositoryMock.cachedPosts).thenReturn(mockPosts);
      when(postsRepositoryMock.fetchNewPosts(any))
          .thenAnswer((_) async => mockPosts);
      when(favoritesRepositoryMock.isFavorite(any)).thenAnswer(
          (Invocation invocation) => invocation.positionalArguments.first == 1);

      return PostListPageBloc();
    },
    act: (PostListPageBloc bloc) {
      bloc.add(PostListPageEvent.tryLoadNextPage());
      bloc.add(PostListPageEvent.setFavoritesFilter(active: true));
      bloc.add(PostListPageEvent.setFavoritesFilter(active: false));
    },
    expect: [
      PostListPageState.initial().withNewElements(mockPosts),
      PostListPageState.initial()
          .withNewElements(mockPosts)
          .withFilters([mockPosts.first], mockFilters),
      PostListPageState.initial().withNewElements(mockPosts),
    ],
  );
}
