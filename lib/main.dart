import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:htd_poc/bloc/favorites/favorites_bloc.dart';
import 'package:htd_poc/services/favorites_repository.dart';
import 'package:htd_poc/services/posts_repository.dart';
import 'package:htd_poc/services/users_repository.dart';
import 'package:htd_poc/ui/pages/post_list_page.dart';

final GetIt locator = GetIt.instance;

void main() {
  _registerServices();
  runApp(AppRoot());
}

void _registerServices() {
  locator.registerLazySingleton<PostsRepository>(() => PostsRepository());
  locator.registerLazySingleton<UsersRepository>(() => UsersRepository());
  locator
      .registerLazySingleton<FavoritesRepository>(() => FavoritesRepository());
}

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTD PoC',
      theme: ThemeData.dark(),
      home: BlocProvider<FavoritesBloc>(
        create: (_) => FavoritesBloc(),
        child: PostListPage(),
      ),
    );
  }
}
