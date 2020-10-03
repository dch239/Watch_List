import 'package:dio/dio.dart';
import 'package:watch_list/constants.dart';
import 'package:watch_list/movie_brain/movie_class.dart';
import 'package:watch_list/tools/globals.dart';
import 'api_response.dart';

class MoviesApiClient {
  static String baseURL = 'https://api.themoviedb.org/3';
  static String apiKey = '357e12233248ebf482e0344e18e811ba';
  static String defaultConfiguration = 'language=en-US';
  static List<String> movieSortBy = [
    "popularity.desc",
    "primary_release_date.desc",
    "vote_average.desc",
    "revenue.desc",
  ];
  static List<String> tvSortBy = [
    "popularity.desc",
    "first_air_date.desc",
    "vote_average.desc",
  ];

  static String discoverURL = (typeChoice == 1)
      ? '$baseURL/discover/movie?api_key=$apiKey&$defaultConfiguration&sort_by=${movieSortBy[sortChoice - 1]}'
      : '$baseURL/discover/tv?api_key=$apiKey&$defaultConfiguration&sort_by=${tvSortBy[sortChoice - 1]}';

  Future<List<Movie>> fetchMovies(int page) async {
    Response response = await Dio().get(discoverURL +
        '&page=$page' +
        '&release_date.lte=$formattedDate' +
        '&vote_count.gte=50');
    return RequestResponse.fromJson(response.data).results;
  }

  Future<String> fetchYoutubeId(String Id) async {
    String type = (typeChoice == 1) ? 'movie' : 'tv';
    String fetchURL = '$baseURL/$type/$Id/videos?api_key=$apiKey';
    Response response = await Dio().get(fetchURL);
    String youtubeId = response.data['results'][0]['key'];
    print(youtubeId);
    return youtubeId;
  }
}
