import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'file:///D:/Project/bhetghat/watch_list/lib/movie_bloc_brain/bog_export.dart';
import 'file:///D:/Project/bhetghat/watch_list/lib/screens/detail_screen.dart';
import '../tools/progress_bar_more.dart';
import 'errors.dart';
import '../tools/progress_bar_init_load.dart';
import 'file:///D:/Project/bhetghat/watch_list/lib/widgets/movie_list.dart';

import 'package:watch_list/constants.dart';

class MoviesBlocWidget extends StatefulWidget {
  const MoviesBlocWidget({Key key, this.bloc, this.event});
  final MoviesBloc bloc;
  final MoviesEvent event;

  @override
  _MoviesBlocWidgetState createState() => _MoviesBlocWidgetState();
}

class _MoviesBlocWidgetState extends State<MoviesBlocWidget> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  MoviesBloc _moviesBloc;
  MoviesEvent _event;

  @override
  void initState() {
    _moviesBloc = widget.bloc;
    _event = widget.event ?? Fetch();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      bloc: _moviesBloc..add(_event),
      builder: (context, state) {
        if (state is MoviesFetched) {
          return GridView.builder(
            key: PageStorageKey('movies_list'),
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return index >= state.movies.length
                  ? BottomLoader()
                  : MovieListItem(
                      movie: movie,
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoviesDetailPage(
                              movie: movie,
                            ),
                          ),
                        );
                      },
                    );
            },
            itemCount: state.movies.length,
            controller: _scrollController,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          );
        }
        if (state is MoviesEmpty) {
          return ErrorMessageWidget(
            message: 'There are no movies for this query.',
            textKey: emptyStateKey,
          );
        }
        if (state is MoviesError) {
          return ErrorMessageWidget(
            message: "Something went wrong :')",
            textKey: errorStateKey,
          );
        }
        return LoadingIndicator();
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _moviesBloc.add(_event);
    }
  }
}
