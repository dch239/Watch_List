import 'package:meta/meta.dart';
import 'package:watch_list/api/api_client.dart';
import 'movie_class.dart';

class MoviesRepository {
  final MoviesApiClient moviesApiClient;

  MoviesRepository({@required this.moviesApiClient})
      : assert(moviesApiClient != null);

  Future<List<Movie>> fetchMovies(int page) async {
    return await moviesApiClient.fetchMovies(page);
  }
}
