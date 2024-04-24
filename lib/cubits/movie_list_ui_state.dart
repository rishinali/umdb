import 'package:umdb/models/popular_movie_response.dart';

sealed class UIState {}

// Initial state class defined as part of the [UIState].
class Initial extends UIState {}

// Loading state class defined as part of the [UIState].
class Loading extends UIState {}

// Success state class defined as part of the [UIState].
class Success extends UIState {
  Success(this.movieList);

  final List<PopularMovie> movieList;
}

// Error state class defined as part of the [UIState].
class Error extends UIState {}

// NOTE: Each state has to be defined with in the same file of the sealed class.
