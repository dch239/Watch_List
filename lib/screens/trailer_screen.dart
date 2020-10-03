import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerScreen extends StatefulWidget {
  final youtubeId;

  const TrailerScreen({Key key, this.youtubeId}) : super(key: key);

  @override
  _TrailerScreenState createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: widget.youtubeId,
        flags: YoutubePlayerFlags(autoPlay: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Trailer'),
      ),
      body: SafeArea(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          //   onReady () {
          // _controller.addListener(listener);
          // },
        ),
      ),
    );
  }
}
