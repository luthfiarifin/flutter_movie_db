import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/theme.dart';
import 'package:movie_db/widgets/item_movie_home.dart';

class MovieList extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;

  MovieList({required this.title, required this.movies, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Text(
            title,
            style: tsTitle2.copyWith(
              fontWeight: medium,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 250,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return ItemMovieHome(movie: movies[index]);
            },
          ),
        )
      ],
    );
  }
}
