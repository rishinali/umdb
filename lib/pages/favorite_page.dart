import 'package:flutter/material.dart';

import 'package:umdb/widgets/favorite_movie_list_cubit.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: const FavoriteMovieListCubit(),
    );
  }
}
