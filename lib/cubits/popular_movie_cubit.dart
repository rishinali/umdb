import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:umdb/cubits/movie_list_ui_state.dart';
import 'package:umdb/models/popular_movie_response.dart';

class PopularMovieCubit extends Cubit<UIState> {
  // This cubit is initialized with the initial state by passing it to super.
  PopularMovieCubit() : super(Initial());

  // Method fetches the favorite movies and emitting corresponding state.
  void getPopularMovies() async {
    // Emit the [Loading] state when starting to fetch the movie list.
    emit(Loading());
    final popularMovieList = await _fetchDataFromJson();

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

  // Method to fetch the popular movies from the json file.
  Future<List<PopularMovie>> _fetchDataFromJson() async {
    // Read the movies from the json file.
    final jsonString =
        await rootBundle.loadString('assets/popular_movies.json');

    // Parse the string to the json object.
    final popularMoviesResponse = jsonDecode(jsonString);

    // Each json object in the json array [items] is mapped to
    // [PopularMovie] object and returned as a list of [PopularMovie]
    // using the [fromJson] method defined in the model class.
    final movieList = (popularMoviesResponse['items'] as List<dynamic>)
        .map((movieJson) => PopularMovie.fromJson(movieJson));
    return movieList.toList();
  }
}
