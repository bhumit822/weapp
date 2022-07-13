import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:weapp/Screens/week5/videoPlayer/videoplayerControler.dart';
import 'package:weapp/constdata/textstyles.dart';

class VideoPlayerDemo extends StatefulWidget {
  const VideoPlayerDemo({Key? key}) : super(key: key);

  @override
  State<VideoPlayerDemo> createState() => _VideoPlayerDemoState();
}

class _VideoPlayerDemoState extends State<VideoPlayerDemo> {
  @override
  void initState() {
    super.initState();
  }

  VideoDEmoController _controller = Get.put(VideoDEmoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Video Player",
          style: AppTextStyles.h3_Bold,
        ),
      ),
      body: Obx(() => _controller.folders.value.isEmpty
          ? Material(
              color: Colors.transparent,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView.builder(
              itemCount: _controller.folders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    _controller.getFileList(index);
                    _controller.folderName.value =
                        _controller.folders[index].name;
                  },
                  title: Text(_controller.folders[index].name == ""
                      ? "Internal Storage"
                      : _controller.folders[index].name),
                  subtitle:
                      Text("${_controller.folders[index].assetCount} Video"),
                );
              },
            )),
    );
  }
}
