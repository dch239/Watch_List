import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'movie_brain/genre_class.dart';

const kMoviePageTitle = [
  "Popular Movies",
  "Latest Movies",
  "Top Rated Movies",
  "Top Grossing Movies",
];
const kTVPageTitle = [
  "Popular TV Shows",
  "Latest TV Shows",
  "Top Rated TV Shows",
];

const emptyStateKey = Key('empty_state_label');
const errorStateKey = Key('error_state_label');

const String imagePrefix = 'https://image.tmdb.org/t/p/w500';

const titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w300);
const kDescriptionTextStyle =
    TextStyle(fontSize: 15, fontWeight: FontWeight.w300);

//todo: move genre
final List<Genre> genres = [
  {"id": 28, "name": "Action"},
  {"id": 12, "name": "Adventure"},
  {"id": 10759, "name": "Action & Adventure"},
  {"id": 16, "name": "Animation"},
  {"id": 35, "name": "Comedy"},
  {"id": 80, "name": "Crime"},
  {"id": 99, "name": "Documentary"},
  {"id": 18, "name": "Drama"},
  {"id": 10751, "name": "Family"},
  {"id": 14, "name": "Fantasy"},
  {"id": 36, "name": "History"},
  {"id": 27, "name": "Horror"},
  {"id": 10762, "name": "Kids"},
  {"id": 10402, "name": "Music"},
  {"id": 9648, "name": "Mystery"},
  {"id": 10763, "name": "News"},
  {"id": 10764, "name": "Reality"},
  {"id": 10749, "name": "Romance"},
  {"id": 878, "name": "Science Fiction"},
  {"id": 10765, "name": "Sci-Fi & Fantasy"},
  {"id": 10766, "name": "Soap"},
  {"id": 10767, "name": "Talk"},
  {"id": 10770, "name": "TV Movie"},
  {"id": 53, "name": "Thriller"},
  {"id": 10752, "name": "War"},
  {"id": 10768, "name": "War & Politics"},
  {"id": 37, "name": "Western"}
].map((genreMap) => Genre.fromJson(genreMap)).toList();

List<Genre> genresBy(List<int> genreIds) {
  List<Genre> result = [];
  genreIds.forEach((genreId) {
    result.add(genres.firstWhere((genre) => genre.id == genreId));
  });
  return result;
}

var now = DateTime.now();
var formatter = DateFormat('yyyy-MM-dd');
String formattedDate = formatter.format(now);
