import 'package:watch_list/movie_brain/movie_class.dart';

class RequestResponse {
  int page;
  int totalResults;
  int totalPages;
  List<Movie> results;

  RequestResponse(
      {this.page, this.totalResults, this.totalPages, this.results});

  RequestResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = List<Movie>();
      json['results'].forEach((movie) {
        results.add(Movie.fromJson(movie));
      });
    }
  }
}
