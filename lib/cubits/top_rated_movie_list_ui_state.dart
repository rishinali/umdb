import 'package:umdb/models/top_rated_movie_response.dart';

sealed class TopRatedMovieListUIState {}

// Loading state class defined as part of the [TopRatedMovieListUIState].
class Initial extends TopRatedMovieListUIState {}

// Loading state class defined as part of the [TopRatedMovieListUIState].
class Loading extends TopRatedMovieListUIState {}

// Success state class defined as part of the [TopRatedMovieListUIState].
class Success extends TopRatedMovieListUIState {
  Success(this.movieList);

  final List<TopRatedMovie> movieList;
}

// Error state class defined as part of the [TopRatedMovieListUIState].
class Error extends TopRatedMovieListUIState {}

// NOTE: Each state has to be defined with in the same file of the sealed class.
