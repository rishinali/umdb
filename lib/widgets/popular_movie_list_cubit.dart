import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:umdb/cubits/movie_list_ui_state.dart';
import 'package:umdb/cubits/popular_movie_cubit.dart';
import 'package:umdb/models/popular_movie_hive.dart';

class PopularMovieListCubit extends StatefulWidget {
  const PopularMovieListCubit({super.key});

  @override
  State<PopularMovieListCubit> createState() => _PopularMovieListCubitState();
}

class _PopularMovieListCubitState extends State<PopularMovieListCubit> {
  late Box<PopularMovieHive> _movieBox;
  late List<PopularMovieHive> _favoriteMovieHiveList;

  @override
  void initState() {
    super.initState();

    // [getPopularMovies] method of the [PopularMovieCubit] is called
    // to fetch the list of movies from the json file.
    context.read<PopularMovieCubit>().getPopularMovies();

    // Defines a variable name for the [popular-movies] Hive box.
    _movieBox = Hive.box<PopularMovieHive>('popular-movies');

    // This method is used to fetch the favorite movie list
    // from the Hive database.
    _fetchFavoriteMovies();
  }

  // Method for saving the movie to the Hive database.
  void _saveMovie(PopularMovieHive movie) {
    // Movie is added to the Hive database.
    _movieBox.add(movie);

    // SetState is called after fetching the favorite movie list again.
    setState(() => _fetchFavoriteMovies());
  }

  // Method for deleting the movie from the Hive database.
  void _deleteMovie(PopularMovieHive movie) {
    // Movie is deleted using the in-built delete method of [HiveObject].
    movie.delete();

    // SetState is called after fetching the favorite movie list again.
    setState(() => _fetchFavoriteMovies());
  }

  // Method for fetching the movie list from the [_movieBox].
  void _fetchFavoriteMovies() {
    // This return a [PopularMovieHive] list and assigns to the variable.
    _favoriteMovieHiveList = _movieBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    // [BlocProvider] is used to watch the [PopularMovieCubit]
    // for each of the states defined in the [UIState].
    return BlocBuilder<PopularMovieCubit, UIState>(
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
                // The UI is built for the movie at the [index] of [movieList].
                final movie = state.movieList[index];

                // Checking whether the current movie is part of the
                // [_favoriteMovieHiveList] by matching [title].
                final isFavorite = _favoriteMovieHiveList.any(
                    (favoriteHiveMovie) =>
                        favoriteHiveMovie.title == movie.title);

                // Declaring a late Hive movie object.
                late PopularMovieHive? favoriteMovieHive;

                // If the movie is part of the [_favoriteMovieHiveList]
                // the movie is retrieved from the list for later usage.
                if (isFavorite) {
                  // Assign value to the favorite movie hive object
                  // if it is present in the favorite movie list.
                  favoriteMovieHive = _favoriteMovieHiveList.firstWhere(
                      (favoriteHiveMovie) =>
                          favoriteHiveMovie.title == movie.title);
                }
                return ListTile(
                  title: Text(movie.title ?? 'No title'),
                  subtitle: Text(movie.year ?? '1900'),
                  onTap: () {
                    // Declaring a late Hive movie object.
                    late PopularMovieHive? movieHive;

                    // If the movie is not in the favorite movie list,
                    // create a [PopularMovieHive] for saving it to the list.
                    if (!isFavorite) {
                      // Assigning the Hive movie object if its in favorites.
                      movieHive = PopularMovieHive(
                        title: movie.title,
                        year: movie.year,
                      );
                    }

                    // Save/delete movie to/from the list based on [isFavorite].
                    isFavorite
                        // The hive object is made non-null since it will
                        // not be null if the movie is present in favorites.
                        ? _deleteMovie(favoriteMovieHive!)
                        // The hive object is made non-null since it will
                        // not be null if the movie is not present in favorites.
                        : _saveMovie(movieHive!);
                  },

                  // The list tile color is assigned based on favorite or not.
                  tileColor: isFavorite ? Colors.black12 : Colors.white,
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
