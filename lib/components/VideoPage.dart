import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_91porn.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String videoPage;

  const VideoPage(this.videoPage);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController _controller;
  String videoUrl = '';

  @override
  void initState() {
    super.initState();
    getVideoUrl();

    _controller = VideoPlayerController.network(
        'http://techslides.com/demos/sample-videos/small.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  Future<void> getVideoUrl() async {
    var _videoUrl = await Api91PornDetail(widget.videoPage).getVideoUrl();
    setState(() {
      this.videoUrl = _videoUrl;
      // this._controller.dispose();
      this._controller = VideoPlayerController.network(this.videoUrl)
        ..initialize().then((_) {
          setState(() {});
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('视频页'),
        centerTitle: true,
      ),
      body: Center(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
