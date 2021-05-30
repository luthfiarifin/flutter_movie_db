import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_db/models/movie_model.dart';

class MovieData {
  static Future<List<MovieModel>> getUpComing(BuildContext context) async {
    try {
      String data = await DefaultAssetBundle.of(context)
          .loadString("assets/json/movie_popular.json");

      List<MovieModel> movies = [];
      List parsedJson = json.decode(data);

      parsedJson.forEach((model) {
        movies.add(MovieModel.fromJson(model));
      });

      return movies.take(8).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
