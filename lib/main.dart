import 'package:flutter/material.dart';
import 'package:watch_list/screens/choice_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:watch_list/screens/home_screen.dart';
import 'api/api_client.dart';
import 'movie_bloc_brain/blocDelegate.dart';
import 'movie_brain/movie_repo.dart';
import 'package:watch_list/movie_bloc_brain/blocs.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final moviesRepository = MoviesRepository(moviesApiClient: MoviesApiClient());
  runApp(BlocProvider<MoviesBloc>(
    create: (context) {
      return MoviesBloc(moviesRepository: moviesRepository);
    },
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final MoviesRepository moviesRepository;

  const MyApp({Key key, this.moviesRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(primaryColor: Color(0xFF161616)),
      initialRoute: '/',
      routes: {
        '/': (context) => ChoiceScreen(),
        '/main': (context) => HomePage(),
        // '/second': (context) => CityScreen(),
      },
    );
  }
}
