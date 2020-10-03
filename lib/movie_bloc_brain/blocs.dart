import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:watch_list/movie_bloc_brain/state.dart';
import '../movie_brain/movie_class.dart';
import '../movie_brain/movie_repo.dart';
import 'bog_export.dart';
import 'events.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository moviesRepository;

  MoviesBloc({
    @required this.moviesRepository,
  }) : assert(moviesRepository != null);

  MoviesState get initialState => MoviesUninitialized();

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    final currentState = state;
    if (event is Fetch) {
      try {
        if (currentState is MoviesUninitialized) {
          final movies = await moviesRepository.fetchMovies(1);
          if (movies.isEmpty) {
            yield MoviesEmpty();
          } else {
            yield MoviesFetched(movies: movies, hasReachedMax: false);
          }
          return;
        }
        if (currentState is MoviesFetched) {
          final movies = await moviesRepository
              .fetchMovies(_getNextPage(currentState.movies));
          yield movies.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : MoviesFetched(
                  movies: currentState.movies + movies,
                  hasReachedMax: false,
                );
          return;
        }
      } catch (error) {
        yield MoviesError(error: error.toString());
      }
    }
  }
}

int _getNextPage(List<Movie> movies) {
  return movies.length ~/ 20 + 1;
}
