import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:htd_poc/bloc/favorites/favorites_bloc.dart';
import 'package:htd_poc/main.dart';
import 'package:htd_poc/services/favorites_repository.dart';
import 'package:htd_poc/ui/widgets/favorite_indicator.dart';
import 'package:mockito/mockito.dart';

class FavoritesRepositoryMock extends Mock implements FavoritesRepository {}

void main() {
  FavoritesRepository favoritesRepositoryMock;

  FavoritesBloc bloc;

  setUp(() {
    favoritesRepositoryMock = FavoritesRepositoryMock();

    locator.registerSingleton<FavoritesRepository>(favoritesRepositoryMock);

    bloc = FavoritesBloc();
  });

  tearDown(() {
    bloc.close();
    locator.reset();
  });

  Widget makeTestableWidget(Widget child) {
    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: BlocProvider(
          create: (_) => bloc,
          child: child,
        ),
      ),
    );
  }

  testWidgets('should change icon when in button mode and tapped',
      (WidgetTester tester) async {
    bool toggled = true;
    when(favoritesRepositoryMock.favorites).thenAnswer((_) {
      toggled = !toggled;
      return toggled ? {} : {1};
    });

    final Widget testWidget = makeTestableWidget(
      FavoriteIndicator(
        postId: 1,
        showAsButton: true,
      ),
    );

    await tester.runAsync(() async {
      await tester.pumpWidget(testWidget);

      final Finder nonFavoritedIcon =
          find.byIcon(Icons.favorite_outline_rounded);
      final Finder favoritedIcon = find.byIcon(Icons.favorite_rounded);

      expect(nonFavoritedIcon, findsOneWidget);
      expect(favoritedIcon, findsNothing);

      await tester.tap(nonFavoritedIcon);
      await tester.pump();

      expect(nonFavoritedIcon, findsNothing);
      expect(favoritedIcon, findsOneWidget);

      await tester.tap(favoritedIcon);
      await tester.pump();

      expect(nonFavoritedIcon, findsOneWidget);
      expect(favoritedIcon, findsNothing);
    });
  });

  testWidgets('should show correct icon when post is favorite',
      (WidgetTester tester) async {
    when(favoritesRepositoryMock.favorites).thenAnswer((_) => {1});

    final Widget testWidget = makeTestableWidget(
      FavoriteIndicator(postId: 1),
    );

    bloc.add(FavoritesEvent.toggle(1));

    await tester.runAsync(() async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      final Finder favoritedIcon = find.byIcon(Icons.favorite_rounded);

      expect(favoritedIcon, findsOneWidget);
    });
  });

  testWidgets('should show nothing when post is not favorite',
      (WidgetTester tester) async {
    when(favoritesRepositoryMock.favorites).thenAnswer((_) => {1});

    final Widget testWidget = makeTestableWidget(
      FavoriteIndicator(postId: 1),
    );

    await tester.pumpWidget(testWidget);

    final Finder favoritedIcon = find.byIcon(Icons.favorite_rounded);

    expect(favoritedIcon, findsNothing);
  });
}
