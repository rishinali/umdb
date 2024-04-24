import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:umdb/cubits/favorite_movie_cubit.dart';
import 'package:umdb/cubits/popular_movie_cubit.dart';
import 'package:umdb/cubits/top_rated_movie_cubit.dart';
import 'package:umdb/models/popular_movie_hive.dart';
import 'package:umdb/pages/splash_page.dart';

void main() async {
  // Need to call this method if you need the binding
  // to be initialized before calling [runApp].
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes Hive.
  await Hive.initFlutter();

  // Register a TypeAdapter to announce it to Hive.
  // Here the [PopularMovieAdapter] is registered to the Hive.
  Hive.registerAdapter(PopularMovieAdapter());

  // Opens the Hive box named [popular-movies].
  // This only need to do once in the app.
  await Hive.openBox<PopularMovieHive>('popular-movies');

  runApp(const UmdbApp());
}

class UmdbApp extends StatelessWidget {
  const UmdbApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // [MultiBlocProvider] converts the [BlocProvider] list into
    // a tree of nested [BlocProvider] widgets.
    return MultiBlocProvider(
      // The [Providers] are passed into the list below.
      // Here the [PopularMovieCubit], [FavoriteMovieCubit],
      // [TopRatedMovieCubit] are passed in to the list.
      providers: [
        BlocProvider(create: (BuildContext context) => PopularMovieCubit()),
        BlocProvider(create: (BuildContext context) => FavoriteMovieCubit()),
        BlocProvider(create: (context) => TopRatedMovieCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        // [SplashPage] is set as the default page
        // to show when opening the app
        home: const SplashPage(),
      ),
    );
  }
}
