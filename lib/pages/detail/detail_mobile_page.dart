import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_db/data/movie_data.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/widgets/movie_list.dart';
import 'package:share_plus/share_plus.dart';

import '../../theme.dart';
import '../../util.dart';

class DetailMobilePage extends StatelessWidget {
  final MovieModel movie;

  const DetailMobilePage({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(context),
            _body(),
            _similar(context),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('${Util.W500_IMAGE}${movie.posterPath}'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          primaryColor.withOpacity(0.1),
                          primaryColor.withOpacity(0.4),
                          primaryColor.withOpacity(0.5),
                          primaryColor.withOpacity(0.7),
                        ])),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 16),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: whiteColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, right: 16),
              child: IconButton(
                onPressed: () {
                  Share.share("${Util.WEB_MOVIE_URL}${movie.id}", subject: 'Share this movie!');
                },
                icon: Icon(
                  Icons.share,
                  color: whiteColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _body() {
    return Container(
      transform: Matrix4.translationValues(0, -50, 0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              softWrap: true,
              style: tsTitle1.copyWith(fontSize: 22, height: 1),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            Util.formatDate(movie.releaseDate, outputType: 'dd MMMM, yyyy'),
            style: tsTitle3.copyWith(
              color: Colors.grey.shade300,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                movie.voteAverage.toString(),
                style: tsTitle3.copyWith(
                  color: Colors.amber,
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
                  itemSize: 16,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (_) {}),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 16,
              left: 16,
            ),
            child: Text(
              movie.overview,
              style: tsTitle3.copyWith(
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _similar(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0, -44, 0),
      child: FutureBuilder(
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
      ),
    );
  }
}
