import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_db/data/movie_data.dart';
import 'package:movie_db/pages/movie_page.dart';
import 'package:movie_db/theme.dart';

import '../util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _toolbarState = 'Movie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            MoviePage(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Stack(
      children: [
        _currentMovie(),
        _selectionBar(),
      ],
    );
  }

  Widget _selectionBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _textSelectionBar('Tv Show'),
          _textSelectionBar('Movie'),
          _textSelectionBar('Favorite'),
        ],
      ),
    );
  }

  Widget _textSelectionBar(String textState) {
    return InkWell(
      child: Text(textState,
          style: tsTitle2.copyWith(
            color: _toolbarState == textState ? redColor : whiteColor,
          )),
      onTap: () {
        setState(() {
          _toolbarState = textState;
        });
      },
    );
  }

  Widget _currentMovie() {
    return AspectRatio(
      aspectRatio: 0.690,
      child: FutureBuilder(
          future: MovieData.getHeaderMovie(context),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            else {
              var movie = snapshot.data;

              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        NetworkImage('${Util.W500_IMAGE}${movie.posterPath}'),
                    fit: BoxFit.fitWidth
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
              );
            }
          }),
    );
  }
}
