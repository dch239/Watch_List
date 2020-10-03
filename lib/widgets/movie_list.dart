import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watch_list/tools/globals.dart';
import 'package:watch_list/movie_brain/movie_class.dart';
import 'package:watch_list/widgets/movie_image.dart';

class MovieListItem extends StatefulWidget {
  const MovieListItem({
    Key key,
    @required this.movie,
    @required this.onTapFunction,
  }) : super(key: key);

  final Movie movie;
  final Function onTapFunction;

  @override
  _MovieListItemState createState() => _MovieListItemState();
}

class _MovieListItemState extends State<MovieListItem> {
  void toggleFavorite() {
    setState(() {
      if (!widget.movie.isFavorite) {
        widget.movie.addFavorite(widget.movie);
      } else {
        widget.movie.removeFavorite(widget.movie);
      }
      widget.movie.isFavorite = !widget.movie.isFavorite;
      print(favorites);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key('${widget.movie.id}'),
      onTap: widget.onTapFunction,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.black,
        child: Column(children: <Widget>[
          Expanded(
              flex: 5,
              child: Center(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Container(
                      child: MovieImage(widget.movie),
                      width: double.infinity,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.3),
                      child: IconButton(
                          iconSize: 30,
                          icon: widget.movie.isFavorite
                              ? Icon(Icons.star)
                              : Icon(Icons.star_border),
                          color: Colors.yellow[500],
                          onPressed: toggleFavorite),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.movie.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    shadows: [
                      Shadow(
                        blurRadius: 15.0,
                        color: Colors.black,
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
