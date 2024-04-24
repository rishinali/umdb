import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:umdb/cubits/favorite_movie_cubit.dart';
import 'package:umdb/cubits/movie_list_ui_state.dart';

class FavoriteMovieListCubit extends StatefulWidget {
  const FavoriteMovieListCubit({super.key});

  @override
  State<FavoriteMovieListCubit> createState() => _FavoriteMovieListCubitState();
}

class _FavoriteMovieListCubitState extends State<FavoriteMovieListCubit> {
  @override
  void initState() {
    super.initState();

    // [getFavoriteMovies] method of the [FavoriteMovieCubit] is called
    // to fetch the list of movies from the Hive box.
    context.read<FavoriteMovieCubit>().getFavoriteMovies();
  }

  @override
  Widget build(BuildContext context) {
    // [BlocProvider] is used to watch the [FavoriteMovieCubit]
    // for each of the states defined in the [UIState].
    return BlocBuilder<FavoriteMovieCubit, UIState>(
      builder: (context, state) {
        // The UI is built for each state.
        // The switch is exhaustive as we are using sealed class.
        return switch (state) {
          // Defines the UI for [Initial] state.
          Initial() => const Center(child: CircularProgressIndicator()),

          // Defines the UI for [Loading] state.
          Loading() => const Center(child: CircularProgressIndicator()),

          // Defines the UI for [Success] state.
          Success() => ListView.builder(
              itemCount: state.movieList.length,
              itemBuilder: (context, index) {
                final movie = state.movieList[index];
                return ListTile(
                  title: Text(movie.title ?? 'No title'),
                  subtitle: Text(movie.year ?? '1900'),
                );
              },
            ),

          // Defines the UI for [Error] state.
          Error() => const Center(child: Text('Something went wrong!')),
        };
      },
    );
  }
}
