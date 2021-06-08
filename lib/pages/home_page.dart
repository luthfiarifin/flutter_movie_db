import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_db/data/movie_data.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/pages/movie_page.dart';
import 'package:movie_db/theme.dart';
import 'package:share_plus/share_plus.dart';

import '../util.dart';
import 'detail/detail_page.dart';
import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _toolbarState = 'Movie';

  Future<MovieModel?>? _currentMovieFuture;

  @override
  void initState() {
    _currentMovieFuture = MovieData.getHeaderMovie(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            _body(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return LayoutBuilder(
      builder: (context, BoxConstraints constrains) {
        return _toolbarState == "Favorite" || constrains.maxWidth <= 300
            ? _selectionBar(constrains.maxWidth)
            : constrains.maxWidth >= 500
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 24),
                        child: Text(
                          'Movie App',
                          style: tsTitle1.copyWith(fontSize: 32),
                        ),
                      ),
                      _selectionBar(constrains.maxWidth),
                    ],
                  )
                : Stack(
                    children: [
                      _currentMovie(),
                      _selectionBar(constrains.maxWidth),
                    ],
                  );
      },
    );
  }

  Widget _body() {
    return _toolbarState == "Favorite"
        ? FavoritePage()
        : MoviePage(
            state: _toolbarState,
          );
  }

  Widget _selectionBar(double maxWidth) {
    return Padding(
      padding: EdgeInsets.only(
        top: maxWidth >= 500 ? 8 : 48,
        left: maxWidth >= 500 ? 16 : 0,
        bottom: maxWidth >= 500 ? 24 : 0,
      ),
      child: Row(
        mainAxisAlignment: maxWidth >= 500
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceEvenly,
        children: [
          _textSelectionBar('Tv Show'),
          SizedBox(width: maxWidth >= 500 ? 16 : 0),
          _textSelectionBar('Movie'),
          SizedBox(width: maxWidth >= 500 ? 16 : 0),
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
        if (_toolbarState != textState)
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
          future: _currentMovieFuture,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            else {
              MovieModel movie = snapshot.data;

              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              '${Util.W500_IMAGE}${movie.posterPath}'),
                          fit: BoxFit.fitWidth),
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
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _informationButton(movie),
                            SizedBox(
                              width: 24,
                            ),
                            _shareButton(movie.id)
                          ],
                        ),
                      ))
                ],
              );
            }
          }),
    );
  }

  Widget _shareButton(int id) {
    return InkWell(
      onTap: () {
        Share.share("${Util.WEB_MOVIE_URL}$id", subject: 'Share this movie!');
      },
      child: Container(
        child: Column(
          children: [
            Icon(
              Icons.share,
              color: whiteColor,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Share',
              style: tsTitle3.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  Widget _informationButton(MovieModel movie) {
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
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: whiteColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: primaryColor,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Information',
              style: tsTitle3.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
