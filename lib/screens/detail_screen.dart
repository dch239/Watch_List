import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:watch_list/api/api_client.dart';
import 'package:watch_list/constants.dart';
import 'package:watch_list/screens/trailer_screen.dart';
import 'package:watch_list/tools/date_formatter.dart';
import 'package:watch_list/movie_brain/movie_class.dart';
import 'file:///D:/Project/bhetghat/watch_list/lib/widgets/movie_image.dart';

class MoviesDetailPage extends StatefulWidget {
  const MoviesDetailPage({
    Key key,
    @required this.movie,
  }) : super(key: key);
  final Movie movie;

  @override
  _MoviesDetailPageState createState() => _MoviesDetailPageState();
}

class _MoviesDetailPageState extends State<MoviesDetailPage> {
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List _buildlist() {
      List<Widget> list = [
        Card(
          margin: EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text("Overview: ${widget.movie.title}",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Release Date: ' +
                      DateUtils.formatDate(
                          widget.movie.releaseDate, 'dd MMMM yyyy'),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.movie.overview,
                  style: kDescriptionTextStyle,
                ),
              ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(8),
          child: Wrap(
            children: <Widget>[
              for (var genre in genresBy(widget.movie.genreIds))
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Chip(
                    label: Text(genre.name),
                  ),
                )
            ],
          ),
        ),
        Card(
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RatingBarIndicator(
                  rating: widget.movie.voteAverage / 2,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 50.0,
                  direction: Axis.horizontal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Average Rating: ${widget.movie.voteAverage}",
                      style: kDescriptionTextStyle,
                    ),
                    Text(
                      "Vote Counts: ${widget.movie.voteCount.toString()}",
                      style: kDescriptionTextStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 40,
        // )
      ];
      return list;
    }

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 500,
              floating: true,
              pinned: true,
              flexibleSpace:
                  FlexibleSpaceBar(background: MovieImage(widget.movie)),
            ),
            SliverList(delegate: SliverChildListDelegate(_buildlist()))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          elevation: 0,
          shape: CircularNotchedRectangle(),
          notchMargin: 2,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: (screenSize.width - 20) / 2,
                  child: Text(
                    'Watch',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  width: (screenSize.width - 20) / 2,
                  child: Text(
                    'Trailer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFE31B25),
          onPressed: () async {
            setState(() {
              showSpinner = true;
            });
            MoviesApiClient temp = MoviesApiClient();
            await temp
                .fetchYoutubeId(widget.movie.id.toString())
                .then((value) => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrailerScreen(
                                    youtubeId: value,
                                  )))
                    });
            setState(() {
              showSpinner = false;
            });
            /*Navigator.push(context,
                MaterialPageRoute(builder: (context) => TrailerScreen()));*/
          },
          child: Icon(Icons.play_circle_filled),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
