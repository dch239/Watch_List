import 'package:flutter/material.dart';

import 'file:///D:/Project/bhetghat/watch_list/lib/widgets/movie_list.dart';
import 'package:watch_list/tools/globals.dart';

import 'detail_screen.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({
    Key key,
  }) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Widget> cards = [];
  getListTiles() {
    for (var movie in favorites) {
      MovieListItem cont = MovieListItem(
          movie: movie,
          onTapFunction: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoviesDetailPage(
                    movie: movie,
                  ),
                ));
          });
      cards.add(cont);
    }
    return cards;
  }

  @override
  void initState() {
    getListTiles();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Favorites"),
        ),
        body: ListView(
            padding: EdgeInsets.all(10),
            itemExtent: MediaQuery.of(context).size.height * 0.5,
            children: cards));
  }
}
