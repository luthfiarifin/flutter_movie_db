import 'package:flutter/material.dart';
import 'package:movie_db/data/movie_data.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/widgets/item_movie_favorite.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MovieData.getHomeMovie(context),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        else {
          List<MovieModel> movies = snapshot.data;
          return _favoriteList(movies);
        }
      },
    );
  }

  Widget _favoriteList(List<MovieModel> movies) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 32,
      ),
      crossAxisSpacing: 8,
      mainAxisSpacing: 16,
      children: movies
          .map((movie) =>
          ItemMovieFavorite(
            movie: movie,
          ))
          .toList(),
    );
  }
}

