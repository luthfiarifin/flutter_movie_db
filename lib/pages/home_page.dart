import 'package:flutter/material.dart';
import 'package:movie_db/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _toolbarState = 'Movie';

  Widget textSelectionBar(String textState) {
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

  Widget selectionBar() {
    return Container(
      padding: EdgeInsets.only(
        top: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          textSelectionBar('Tv Show'),
          textSelectionBar('Movie'),
          textSelectionBar('Favorite'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          selectionBar(),
        ],
      )),
    );
  }
}
