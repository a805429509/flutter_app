import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_91porn.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPage extends StatefulWidget {
  final String videoPage;

  const VideoPage(this.videoPage);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController _controller;
  ChewieController _chewieController;
  String videoUrl = '';

  @override
  void initState() {
    super.initState();
    getVideoUrl();

    // 给一个默认的地址。不然会有问题。。
    this._controller = VideoPlayerController.network(
        'http://techslides.com/demos/sample-videos/small.mp4');
    this._chewieController = ChewieController(
        videoPlayerController: this._controller,
        aspectRatio: 3 / 2,
        autoInitialize: false);
  }

  @override
  void dispose() {
    this._controller.dispose();
    this._chewieController.dispose();
    super.dispose();
  }

  Future<void> getVideoUrl() async {
    var _videoUrl = await Api91PornDetail(widget.videoPage).getVideoUrl();
    debugPrint('视频最终地址:' + _videoUrl);
    if (mounted) {
      setState(() {
        this.videoUrl = _videoUrl;
        this._controller = VideoPlayerController.network(this.videoUrl);
        // this._chewieController.dispose();
        this._chewieController = ChewieController(
            videoPlayerController: this._controller,
            aspectRatio: 3 / 2,
            autoPlay: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('视频页'),
        centerTitle: true,
      ),
      body: Chewie(
        controller: this._chewieController,
      ),
    );
  }
}
