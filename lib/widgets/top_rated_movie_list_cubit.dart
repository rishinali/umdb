import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:umdb/cubits/top_rated_movie_cubit.dart';
import 'package:umdb/cubits/top_rated_movie_list_ui_state.dart';

class TopRatedMovieListCubit extends StatefulWidget {
  const TopRatedMovieListCubit({super.key});

  @override
  State<TopRatedMovieListCubit> createState() => _TopRatedMovieListCubitState();
}

class _TopRatedMovieListCubitState extends State<TopRatedMovieListCubit> {

  @override
  void initState() {
    super.initState();

    // [getTopRatedMovies] method of the [TopRatedMovieCubit] is called
    // to fetch the list of movies from the URL.
    context.read<TopRatedMovieCubit>().getTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    // [BlocProvider] is used to watch the [TopRatedMovieCubit]
    // for each of the states defined in the [TopRatedMovieListUIState].
    return BlocBuilder<TopRatedMovieCubit, TopRatedMovieListUIState>(
      builder: (context, state) {
        // The UI is built for each state.
        // The switch is exhaustive as we are using sealed class.
        return switch (state) {
          // Defines the UI for [Initial] state.
          Initial() => const Center(child: CircularProgressIndicator()),

          // Defines the UI for [Loading] state.
          Loading() => const Center(child: CircularProgressIndicator()),

          // Defines the UI for [Success] state.
          Success() => ListView.builder(itemBuilder: (context, index) {
              final movie = state.movieList[index];
              return ListTile(
                title: Text(movie.title ?? "No Title"),
                subtitle: Text(movie.year ?? '1900'),
              );
            }),

          // Defines the UI for [Error] state.
          Error() => const Center(child: Text('Something went wrong!')),
        };
      },
    );
  }
}
