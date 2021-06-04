import 'package:flutter/material.dart';
import 'package:movie_db/data/movie_data.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/widgets/movie_list.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _movieList('Popular Movie'),
        _movieList('Continue Watching'),
        _movieList('Hot Movie'),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _movieList(String title) {
    return FutureBuilder(
      future: MovieData.getHomeMovie(context),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        else {
          List<MovieModel> movies = snapshot.data;

          return MovieList(title: title, movies: movies);
        }
      },
    );
  }
}
