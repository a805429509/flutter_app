import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_91porn.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:path_provider/path_provider.dart';

class VideoPage extends StatefulWidget {
  final String videoPage;
  final String videoName;

  const VideoPage(this.videoName, this.videoPage);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  GlobalKey xx = new GlobalKey();
  VideoPlayerController _controller;
  ChewieController _chewieController;
  String videoUrl = '';
  Directory directory;
  String appDocPath;
  bool needDownload = true;
  File file;
  double jindu;

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
    this.directory = await getApplicationDocumentsDirectory();
    this.appDocPath = directory.path;
    this.file = new File(this.appDocPath + '/' + widget.videoName + '.mp4');
    if (this.file.existsSync()) {
      setState(() {
        this.needDownload = false;
      });
    }
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
    Dio().download(
        this.videoUrl, this.appDocPath + '/' + widget.videoName + '.mp4',
        onReceiveProgress: (received, total) {
      print('已下载' + (received / total * 100).toStringAsFixed(0) + "%");
      if (mounted) {
        if (total != -1) {
          setState(() {
            this.jindu = (received / total).toDouble();
          });
        }
        if (total == received) {
          setState(() {
            this.needDownload = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoName),
        centerTitle: true,
      ),
      // body: Chewie(
      //   controller: this._chewieController,
      // ),
      body: Column(
        children: <Widget>[
          Chewie(
            controller: this._chewieController,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: this.jindu == null
                ? Text('')
                : Column(children: [
                    LinearProgressIndicator(
                      key: xx,
                      value: this.jindu,
                    ),
                    Text('已下载' + (this.jindu * 100).round().toString() + '%')
                  ]),
          )
        ],
      ),

      floatingActionButton: MaterialButton(
        child: this.needDownload ? Icon(Icons.file_download) : Text('已下载'),
        onPressed: this.needDownload ? _downloadVideo : () {},
      ),
    );
  }
}
