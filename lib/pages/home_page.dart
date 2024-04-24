import 'package:flutter/material.dart';

import 'package:umdb/pages/popular_movies_page.dart';
import 'package:umdb/pages/top_rated_movies_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // [DefaultTabController] creates a default tab controller
    // for the given [child] widget.
    return DefaultTabController(
      // The length must match [TabBar.tabs] and [TabBarView.children] length.
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Popular',
                icon: Icon(
                  Icons.stacked_line_chart,
                ),
              ),
              Tab(
                text: 'Top Rated',
                icon: Icon(Icons.timelapse),
              ),
            ],
          ),
        ),

        // Defines the pages for each tabs.
        body: const TabBarView(
          children: [
            PopularMoviesPage(),
            TopRatedMoviesPage(),
          ],
        ),
      ),
    );
  }
}
