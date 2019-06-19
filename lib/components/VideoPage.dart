import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_91porn.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class VideoPage extends StatefulWidget {
  final String videoPage;
  final String videoName;

  const VideoPage(this.videoName, this.videoPage);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController _controller;
  ChewieController _chewieController;
  String videoUrl = '';
  String appDocPath;
  bool needDownload = true;

  @override
  void initState() {
    super.initState();
    // 给一个默认的地址。不然会有问题。。
    print(widget.videoPage);

    if (widget.videoPage.startsWith('file')) {
      this.needDownload = false;
      print('ok');
      var file = new File(widget.videoPage);
      print(file);
      this._controller = VideoPlayerController.file(file);
      this._chewieController = ChewieController(
        videoPlayerController: this._controller,
        aspectRatio: 3 / 2,
        autoPlay: true,
        autoInitialize: true,
      );
      print('ok2');
    } else {
      getVideoUrl();
      getPath();

      this._controller = VideoPlayerController.asset('videos/small.mp4');
      this._chewieController = ChewieController(
          videoPlayerController: this._controller,
          aspectRatio: 3 / 2,
          autoInitialize: false);
    }
  }

  void getPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    this.appDocPath = directory.path;
  }

  @override
  void dispose() {
    this._controller.dispose();
    this._chewieController.dispose();
    super.dispose();
  }

  Future<void> getVideoUrl() async {
    var _videoUrl = await Api91PornDetail(widget.videoPage).getVideoUrl();
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

  void _downloadVideo() async {
    debugPrint('开始下载');
    var video = await http.get(this.videoUrl);
    debugPrint('新建文件完成');
    File file = new File(this.appDocPath + '/' + widget.videoName + '.mp4');
    debugPrint('开始写入');
    file.writeAsBytes(video.bodyBytes);
    debugPrint('写入完成');
    debugPrint(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoName),
        centerTitle: true,
      ),
      body: Chewie(
        controller: this._chewieController,
      ),
      floatingActionButton: MaterialButton(
        child: this.needDownload ? Icon(Icons.file_download) : Text('已下载'),
        onPressed: this.needDownload ? _downloadVideo : () {},
      ),
    );
  }
}
