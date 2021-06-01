import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/data/movie_data.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/theme.dart';
import 'package:movie_db/widgets/movie_list.dart';

import '../util.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> imageSliders(List<MovieModel> movies) {
      return movies
          .map(
            (movie) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: [
                      Image.network(
                        '${Util.W500_IMAGE}${movie.backdropPath}',
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: 16,
                        ),
                        child: Text(
                          movie.title,
                          style: tsTitle3.copyWith(
                            fontWeight: semiBold,
                            shadows: [
                              Shadow(
                                offset: Offset(-0.8, -0.8),
                                color: primaryColor,
                              ),
                              Shadow(
                                offset: Offset(0.8, -0.8),
                                color: primaryColor,
                              ),
                              Shadow(
                                offset: Offset(0.8, 0.8),
                                color: primaryColor,
                              ),
                              Shadow(
                                offset: Offset(-0.8, 0.8),
                                color: primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList();
    }

    Widget comingSoon() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 32,
            bottom: 8,
            left: 16,
            right: 16,
          ),
          child: Text(
            'Coming Soon',
            style: tsTitle1,
          ),
        ),
        Container(
          child: FutureBuilder(
            future: MovieData.getUpComing(context),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              else {
                List<MovieModel> movies = snapshot.data;

                return CarouselSlider(
                  items: imageSliders(movies),
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 4),
                    aspectRatio: 2.1,
                  ),
                );
              }
            },
          ),
        ),
      ]);
    }

    Widget movieList(String title) {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        comingSoon(),
        movieList('Popular Movie'),
        movieList('Continue Watching'),
        movieList('Hot Movie'),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
