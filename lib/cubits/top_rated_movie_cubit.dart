import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:umdb/cubits/top_rated_movie_list_ui_state.dart';
import 'package:umdb/models/top_rated_movie_response.dart';

class TopRatedMovieCubit extends Cubit<TopRatedMovieListUIState> {
  // This cubit is initialized with the initial state by passing it to super.
  TopRatedMovieCubit() : super(Initial());

  // Method fetches the top-rated movies and emitting corresponding state.
  void getTopRatedMovies() async {
    // Emit the [Loading] state when starting to fetch the movie list.
    emit(Loading());
    final topRatedMovies = await _fetchTopRatedFromUrl();

    // This check is to resemble real life case
    // NOTE: Here the check is unnecessary.
    if (topRatedMovies is List<TopRatedMovie>) {
      // Emit the [Success] state with retrieved movie list when success.
      emit(Success(topRatedMovies));
    } else {
      // Emit the [Error] if there is an error.
      emit(Error());
    }
  }

  // Method to fetch the top-rated movies from the url.
  Future<List<TopRatedMovie>> _fetchTopRatedFromUrl() async {
    const topRatedMoviesUrl = 'https://movie-api-rish.onrender.com/top-rated';

    // Url string is parsed into Uri
    final topRatedMovieUri = Uri.parse(topRatedMoviesUrl);

    try {
      // Http GET method is used to fetch the response from the Url.
      final response = await http.get(topRatedMovieUri);

      // The response string is parsed into json object.
      final responseJson = jsonDecode(response.body);

      // Each json object in the json array [items] is mapped to
      // [TopRatedMovie] object and returned as a list of [TopRatedMovie]
      // using the [fromJson] method defined in the model class.
      final topRatedMoviesList = (responseJson['items'] as List<dynamic>)
          .map((topRatedMovie) => TopRatedMovie.fromJson(topRatedMovie))
          .toList();
      return topRatedMoviesList;
    } catch (e) {
      // If there is any error in fetching the data from the url
      // an exception is thrown.
      throw Exception(e);
    }
  }
}
