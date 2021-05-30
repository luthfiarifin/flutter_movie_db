import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/data/movie_data.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/theme.dart';

import '../util.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  int _current = 0;
  Future<List<MovieModel>>? getUpComingFuture;

  @override
  void initState() {
    super.initState();

    getUpComingFuture = MovieData.getUpComing(context);
  }

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
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        bottom: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 24,
                            left: 16,
                          ),
                          child: Text(
                            movie.title,
                            style: tsTitle2.copyWith(
                              fontWeight: semiBold,
                              shadows: [
                                Shadow(
                                    // bottomLeft
                                    offset: Offset(-0.8, -0.8),
                                    color: primaryColor),
                                Shadow(
                                    // bottomRight
                                    offset: Offset(0.8, -0.8),
                                    color: primaryColor),
                                Shadow(
                                    // topRight
                                    offset: Offset(0.8, 0.8),
                                    color: primaryColor),
                                Shadow(
                                    // topLeft
                                    offset: Offset(-0.8, 0.8),
                                    color: primaryColor),
                              ],
                            ),
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
          height: 250,
          child: FutureBuilder(
            future: getUpComingFuture,
            builder: (context, AsyncSnapshot snapshot) {
              List<MovieModel> movies = snapshot.data;

              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData)
                return CircularProgressIndicator();
              else
                return Column(children: [
                  CarouselSlider(
                    items: imageSliders(movies),
                    options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 4),
                        aspectRatio: 2.1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: movies.map((movie) {
                      int index = movies.indexOf(movie);

                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index ? whiteColor : grayColor,
                        ),
                      );
                    }).toList(),
                  ),
                ]);
            },
          ),
        ),
      ]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        comingSoon(),
      ],
    );
  }
}
