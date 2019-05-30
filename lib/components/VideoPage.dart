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

    // 给一个默认的地址。不然会有问题。。
    _controller = VideoPlayerController.network(
        'http://techslides.com/demos/sample-videos/small.mp4');
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  Future<void> getVideoUrl() async {
    var _videoUrl = await Api91PornDetail(widget.videoPage).getVideoUrl();
    debugPrint(_videoUrl);
    setState(() {
      this.videoUrl = _videoUrl;
      this._controller = VideoPlayerController.network(this.videoUrl)
        ..initialize().then((_) {
          setState(() {});
          this._controller.play();
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
            : Container(
                child: Center(
                  child: Text('正在加载中。。。。'),
                ),
              ),
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
