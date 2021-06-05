import 'package:flutter/material.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/pages/detail_page.dart';
import 'package:movie_db/theme.dart';

import '../util.dart';

class ItemMovieHome extends StatelessWidget {
  final MovieModel movie;

  ItemMovieHome({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              movie: movie,
            ),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.only(
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage('${Util.W500_IMAGE}${movie.posterPath}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: tsTitle3,
            ),
            Text(
              Util.formatDate(movie.releaseDate),
              style: tsSubtitle,
            ),
          ],
        ),
      ),
    );
  }
}
