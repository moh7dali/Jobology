// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      "https://www.youtube.com/watch?v=QhYvD0RGCHc",
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            height: 300,
            child: _controller!.value.isInitialized
                ? VideoPlayer(_controller!)
                : Container()),
        SizedBox(
          height: 5,
        ),
        IconButton(
            onPressed: () {
              _controller!.value.isPlaying
                  ? _controller!.pause()
                  : _controller!.play();
            },
            icon: Icon(
                _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow))
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}
