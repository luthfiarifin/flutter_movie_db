import 'package:flutter/material.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/pages/detail/detail_page.dart';
import 'package:movie_db/theme.dart';

import '../util.dart';

class ItemMovieFavorite extends StatelessWidget {
  final MovieModel movie;

  ItemMovieFavorite({required this.movie, Key? key}) : super(key: key);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage('${Util.W500_IMAGE}${movie.posterPath}'),
                  fit: BoxFit.fitWidth,
                ),
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
    );
  }
}
