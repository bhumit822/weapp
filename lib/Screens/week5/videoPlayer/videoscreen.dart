import 'dart:developer';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:weapp/Screens/week5/videoPlayer/videoplayerControler.dart';
import 'package:weapp/constdata/textstyles.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoDEmoController _controller = Get.put(VideoDEmoController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.vController?.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.fileIndex.value = -1;
    _controller.vController?.pause();
    _controller.vController?.removeListener(_controller.plaayListner);
    _controller.vController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                child: SizedBox(
                    height: _controller.vController?.value.size.height,
                    width: _controller.vController?.value.size.width,
                    child: Obx(() => _controller.isPlaying.value
                        ? VideoPlayer(_controller.vController!)
                        : Center(child: CircularProgressIndicator())))),
          ),
          Column(
            children: [
              Obx(
                () => AnimatedOpacity(
                  duration: Duration(milliseconds: 400),
                  opacity: _controller.showContolls.value ? 1 : 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                          ],
                          stops: [
                            0.1,
                            0.4,
                            0.9
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                    ),
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Obx(
                      () => !_controller.showContolls.value
                          ? SizedBox(
                              child: GestureDetector(
                                onTapDown: (v) {
                                  _controller.showContolls.value =
                                      !_controller.showContolls.value;
                                  print("object");
                                },
                              ),
                            )
                          : Column(
                              // mainAxisAlignment:
                              // MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: AppColors.white,
                                        )),
                                    // SizedBox(
                                    //   width: 30,
                                    // ),
                                    Flexible(
                                      child: Text(
                                        "${_controller.files[_controller.fileIndex.value].title}",
                                        style: AppTextStyles.h4_Bold
                                            .copyWith(color: AppColors.white),
                                        maxLines: 2,
                                        // overflow: TextOverflow.,
                                      ),
                                    )
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Obx(
                                          () => IconButton(
                                              onPressed: () {
                                                if (_controller.isMute.value) {
                                                  _controller.vController
                                                      ?.setVolume(2);
                                                  _controller.isMute.value =
                                                      !_controller.isMute.value;
                                                } else {
                                                  _controller.vController
                                                      ?.setVolume(0);
                                                  _controller.isMute.value =
                                                      !_controller.isMute.value;
                                                }
                                              },
                                              icon: _controller.isMute.value
                                                  ? Icon(
                                                      Icons.volume_off,
                                                      color: Colors.white,
                                                    )
                                                  : Icon(
                                                      Icons.volume_up,
                                                      color: Colors.white,
                                                    )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Expanded(child: GestureDetector(
                                  onTapUp: (v) {
                                    _controller.showContolls.value =
                                        !_controller.showContolls.value;
                                    print("object");
                                  },
                                )),
                                SizedBox(height: 30),
                                Obx(
                                  () => ProgressBar(
                                    barHeight: 10,
                                    progressBarColor: AppColors.white,
                                    thumbGlowColor: Colors.transparent,
                                    thumbColor: Colors.transparent,
                                    timeLabelPadding: 0,
                                    timeLabelType: TimeLabelType.remainingTime,
                                    progress: _controller.position.value,
                                    total: _controller.totalDuration.value,
                                    timeLabelTextStyle:
                                        AppTextStyles.p1.copyWith(fontSize: 12),
                                    timeLabelLocation: TimeLabelLocation.sides,
                                    onSeek: (v) async {
                                      await _controller.vController!.seekTo(v);
                                    },
                                    // onDragStart: (v) async {
                                    //   await _controller.vController!
                                    //       .seekTo(v.timeStamp);
                                    // },
                                    onDragUpdate: (v) async {
                                      await _controller.vController!
                                          .seekTo(v.timeStamp);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _controller.vController?.seekTo(
                                              Duration(
                                                  seconds: _controller.position
                                                          .value.inSeconds -
                                                      10));
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 15, 0),
                                          child: Icon(
                                            Icons.fast_rewind_rounded,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          final _index =
                                              _controller.fileIndex.value - 1;
                                          _controller.nextAndprev(_index);
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 15, 0),
                                          // color: AppColors.white,
                                          child: Icon(
                                            Icons.skip_previous_rounded,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _controller
                                                  .vController!.value.isPlaying
                                              ? _controller.vController?.pause()
                                              : _controller.vController?.play();
                                          print(_controller.fileIndex.value);
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 15, 0),
                                          // color: AppColors.white,
                                          child: Obx(
                                            () => _controller.isPlaying.value
                                                ? Icon(
                                                    Icons.pause_rounded,
                                                    color: Colors.white,
                                                    size: 50,
                                                  )
                                                : Icon(
                                                    Icons.play_arrow_rounded,
                                                    color: Colors.white,
                                                    size: 50,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          final _index =
                                              _controller.fileIndex.value + 1;
                                          _controller.nextAndprev(_index);
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 15, 0),
                                          // color: AppColors.white,
                                          child: Icon(
                                            Icons.skip_next_rounded,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _controller.vController?.seekTo(
                                              Duration(
                                                  seconds: _controller.position
                                                          .value.inSeconds +
                                                      10));
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 15, 0),
                                          child: Icon(
                                            Icons.fast_forward_rounded,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),

      //             body: Chewie(
      //   controller: _controller.chewie,
      // ),
    );
  }
}
