import 'package:flutter/material.dart';
import 'package:watch_list/constants.dart';
import 'package:watch_list/movie_brain/movie_class.dart';

class MovieImage extends StatelessWidget {
  const MovieImage(this.movie);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: movie.id,
      child: movie.posterPath == null
          ? Icon(
              Icons.movie,
              //size: 48,
            )
          : Image.network(
              imagePrefix + movie.posterPath,
              fit: BoxFit.cover,
            ),
    );
  }
}
