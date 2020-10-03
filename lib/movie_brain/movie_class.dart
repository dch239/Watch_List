import 'package:watch_list/tools/globals.dart';

class Movie {
  String posterPath;
  int id;
  List<int> genreIds;
  String title;
  String overview;
  String releaseDate;
  int voteCount;
  bool isFavorite;
  var voteAverage;

  Movie(
      {this.posterPath,
      this.id,
      this.genreIds,
      this.title,
      this.overview,
      this.releaseDate,
      this.voteCount,
      this.voteAverage,
      this.isFavorite});

  void addFavorite(Movie movie) {
    favorites.add(movie);
  }

  void removeFavorite(Movie movie) {
    favorites.remove(movie);
  }

  Movie.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path'];
    id = json['id'];
    genreIds = json['genre_ids'].cast<int>();
    title = (typeChoice == 1) ? json['title'] : json['name'];
    overview = json['overview'];
    releaseDate =
        (typeChoice == 1) ? json['release_date'] : json['first_air_date'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    isFavorite = false;
  }

  @override
  String toString() {
    return title;
  }
}
