import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list/constants.dart';
import 'package:watch_list/movie_bloc_brain/blocs.dart';
import 'package:watch_list/screens/favorites_screen.dart';
import 'package:watch_list/widgets/bloc_widget.dart';
import 'package:watch_list/tools/globals.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit the App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              //SizedBox(height: 16),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        //backgroundColor: Colors.white60,
        appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoritePage()))
                        .then((value) {
                      setState(() {});
                    });
                  })
            ],
            title: (typeChoice == 1)
                ? Text(kMoviePageTitle[sortChoice - 1])
                : Text(kTVPageTitle[sortChoice - 1])),
        body: MoviesBlocWidget(
          bloc: BlocProvider.of<MoviesBloc>(context),
        ),
      ),
    );
  }
}
