import 'package:flutter/material.dart';
import 'package:movie_db/theme.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor
      ),
      home: HomePage(),
    );
  }
}
