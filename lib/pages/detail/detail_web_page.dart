import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_db/data/movie_data.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/widgets/movie_list.dart';
import 'package:share_plus/share_plus.dart';

import '../../theme.dart';
import '../../util.dart';

class DetailWebPage extends StatelessWidget {
  final MovieModel movie;

  const DetailWebPage({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 64,
        ),
        child: Center(
          child: Container(
            width: 1200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context),
                SizedBox(height: 32),
                _body(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Text(
      'Movie App',
      style: tsTitle1.copyWith(fontSize: 32),
    );
  }

  Widget _body(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                child: Image.network(
                  '${Util.W500_IMAGE}${movie.backdropPath}',
                  fit: BoxFit.fitWidth,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              SizedBox(
                height: 10,
              ),
              _similar(context),
            ],
          ),
        ),
        SizedBox(width: 32),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      style: tsTitle3.copyWith(fontSize: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        Share.share("${Util.WEB_MOVIE_URL}${movie.id}",
                            subject: 'Share this movie!');
                      },
                      icon: Icon(
                        Icons.share,
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  Util.formatDate(movie.releaseDate,
                      outputType: 'dd MMMM, yyyy'),
                  style: tsTitle3.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      movie.voteAverage.toString(),
                      style: tsTitle3.copyWith(
                        color: Colors.amber,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: movie.voteAverage / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        onRatingUpdate: (_) {}),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    movie.overview,
                    textAlign: TextAlign.justify,
                    style: tsTitle3.copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _similar(BuildContext context) {
    return FutureBuilder(
      future: MovieData.getSimilar(context, movie.id),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        else {
          List<MovieModel> movies = snapshot.data;

          return MovieList(
            title: 'Similar movie',
            movies: movies,
          );
        }
      },
    );
  }
}
