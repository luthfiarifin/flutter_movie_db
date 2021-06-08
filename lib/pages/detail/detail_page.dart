import 'package:flutter/material.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/pages/detail/detail_mobile_page.dart';

class DetailPage extends StatelessWidget {
  final MovieModel movie;

  const DetailPage({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      if (constraints.maxWidth > 800) {
        return DetailMobilePage(
          movie: movie,
        );
      } else {
        return DetailMobilePage(
          movie: movie,
        );
      }
    });
  }
}
