import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:umdb/cubits/movie_list_ui_state.dart';
import 'package:umdb/models/popular_movie_hive.dart';
import 'package:umdb/models/popular_movie_response.dart';

class FavoriteMovieCubit extends Cubit<UIState> {
  // This cubit is initialized with the initial state by passing it to super.
  FavoriteMovieCubit() : super(Initial());

  // Method fetches the favorite movies and emitting corresponding state.
  void getFavoriteMovies() {
    // Emit the [Loading] state when starting to fetch the movie list.
    emit(Loading());
    final popularMovieList = _fetchFavoriteMovies();

    // This check is to resemble real life case
    // NOTE: Here the check is unnecessary.
    if (popularMovieList is List<PopularMovie>) {
      // Emit the [Success] state with retrieved movie list when success.
      emit(Success(popularMovieList));
    } else {
      // Emit the [Error] if there is an error.
      emit(Error());
    }
  }

  // Method to fetch the favorite movies from the [popular-movies] box.
  List<PopularMovie> _fetchFavoriteMovies() {
    // Fetch the movies from the box as a list.
    final favoriteMovieHiveList =
        Hive.box<PopularMovieHive>('popular-movies').values.toList();

    // Each [PopularMovieHive] object in the list is mapped to
    // [PopularMovie] object and returned as a list of [PopularMovie].
    return favoriteMovieHiveList
        .map((movieHive) => PopularMovie(
              title: movieHive.title,
              year: movieHive.year,
            ))
        .toList();
  }
}
