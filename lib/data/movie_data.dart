import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_db/models/movie_model.dart';

class MovieData {
  static Future<MovieModel?> getHeaderMovie(BuildContext context) async {
    try {
      String data = await DefaultAssetBundle.of(context)
          .loadString("assets/json/movie_popular.json");

      List parsedJson = json.decode(data);

      return MovieModel.fromJson((parsedJson..shuffle()).first);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<MovieModel>> getHomeMovie(BuildContext context) async {
    try {
      String data = await DefaultAssetBundle.of(context)
          .loadString("assets/json/movie_popular.json");

      List<MovieModel> movies = [];
      List parsedJson = json.decode(data);

      parsedJson.forEach((model) {
        movies.add(MovieModel.fromJson(model));
      });

      return (movies..shuffle()).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<MovieModel>> getSimilar(BuildContext context, int id) async {
    try {
      String data = await DefaultAssetBundle.of(context)
          .loadString("assets/json/movie_popular.json");

      List<MovieModel> movies = [];
      List parsedJson = json.decode(data);

      parsedJson.forEach((model) {
        MovieModel movie = MovieModel.fromJson(model);
        if (movie.id != id) movies.add(movie);
      });

      return (movies..shuffle()).take(5).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
