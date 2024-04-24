import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:umdb/models/popular_movie_response.dart';

class PopularMovieListJson extends StatefulWidget {
  const PopularMovieListJson({super.key});

  @override
  State<PopularMovieListJson> createState() => _PopularMovieListJsonState();
}

class _PopularMovieListJsonState extends State<PopularMovieListJson> {
  // Declares the popular movie list as late.
  late List<PopularMovie> _popularMovieList = [];

  @override
  void initState() {
    super.initState();

    // Calling the method to fetch the data from the json file.
    _getPopularMovies();
  }

  void _getPopularMovies() async {
    // Assigning the value to the popular movie list declared earlier.
    _popularMovieList = await _fetchDataFromJson();

    // Calling the SetState to rebuild the [PopularMovieListJson] widget.
    setState(() {});
  }

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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _popularMovieList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_popularMovieList[index].title ?? 'No title'),
          subtitle: Text(_popularMovieList[index].year ?? '1900'),
        );
      },
    );
  }
}
