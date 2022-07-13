import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:weapp/Screens/week5/audioplayer/playerController/audioController.dart';
import 'package:weapp/constdata/iconstring.dart';
import 'package:weapp/constdata/textstyles.dart';

class AudioPlayerDemo extends StatefulWidget {
  const AudioPlayerDemo({Key? key}) : super(key: key);

  @override
  State<AudioPlayerDemo> createState() => _AudioPlayerDemoState();
}

class _AudioPlayerDemoState extends State<AudioPlayerDemo> {
  final _audioPlayerController = Get.put(AudioPlayerController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // viewPermision();

    funnn();
    _status();
  }

  funnn() async {
    await _audioPlayerController.viewPermision();
    setState(() {});

    print(_audioPlayerController.plainindex);
  }

  AudioPlayer _player = AudioPlayer();
  @override
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _player.dispose();
    _cancel(1);
  }

  _status() {
    _player.onPositionChanged.listen((a) {
      _audioPlayerController.setCurrentPosition = a.inSeconds;
    });
    final _sataus = _player.onPlayerStateChanged.listen((event) {
      _audioPlayerController.setPlayerState = event;
      log(_audioPlayerController.playerSate.value.toString());
      if (event == PlayerState.playing) {
        _player.onDurationChanged.listen((event) async {
          final a = await _player.getDuration();

          _audioPlayerController.setTotalDuration = a!.inMilliseconds ~/ 1000;
        });
      } else if (event == PlayerState.completed) {
        if (_audioPlayerController.plainindex <
            _audioPlayerController.audioFilesList.length - 1) {
          int _a = _audioPlayerController.plainindex + 1;

          _player.setSourceBytes(
              File(_audioPlayerController.audioFilesList[_a].data)
                  .readAsBytesSync());
          _audioPlayerController.plaingNowSet =
              _audioPlayerController.audioFilesList[_a];

          _audioPlayerController.chngeIndex =
              _audioPlayerController.plainindex + 1;
        } else {
          _player.stop();
          _player.release();
          _audioPlayerController.setIsPlaying = false;
          _audioPlayerController.chngeIndex =
              _audioPlayerController.audioFilesList.value.length + 1;
        }
      }
    });
  }

  _cancel([int? i]) async {
    _audioPlayerController.chngeIndex =
        _audioPlayerController.audioFilesList.value.length + 1;
    _audioPlayerController.setIsPlaying = false;

    if (i == null) {
      await _player.stop();
      _player.release();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xff1c1c1c),
      body: _audioPlayerController.audioFilesList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _audioPlayerController.audioFilesList.length,
              itemBuilder: (contex, index) {
                final data =
                    _audioPlayerController.audioFilesList[index] as SongModel;

                return Obx(
                  () => Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListTile(
                      tileColor: _audioPlayerController.plainindex == index
                          ? Color(0xff2f2f2f)
                          : Colors.transparent,
                      onTap: () async {
                        // _audioPlayerController.changeIsPlaying();
                        _audioPlayerController.setIsPlaying = true;
                        _audioPlayerController.plaingNowSet = data;

                        log(_audioPlayerController.playerSate.value.toString());
                        _audioPlayerController.plainindex == index &&
                                _audioPlayerController.playerSate ==
                                    PlayerState.playing
                            ? await _player.pause()
                            : _audioPlayerController.plainindex == index &&
                                    _audioPlayerController.playerSate ==
                                        PlayerState.paused
                                ? await _player.resume()
                                : await _player.setSourceBytes(
                                    File(data.data).readAsBytesSync());

                        _audioPlayerController.chngeIndex = index;

                        // _player.onPlayerStateChanged.listen((event) async {
                        //   if (event == PlayerState.PLAYING) {
                        //     if (index == _audioPlayerController.plainindex) {
                        //       await _player.pause();
                        //       log("paused");
                        //     } else {
                        //       await _player
                        //           .playBytes(File(data.data).readAsBytesSync());
                        //     }
                        //   }
                        // });

                        // await _player
                        //     .playBytes(File(data.data).readAsBytesSync());
                      },
                      title: Text(
                        data.displayNameWOExt,
                        style: AppTextStyles.p1.copyWith(
                            color: Color.fromARGB(255, 229, 227, 227)
                                .withOpacity(0.9)),
                      ),
                      trailing: _audioPlayerController.plainindex == index
                          ? Icon(
                              Icons.pause,
                              color: Colors.white.withOpacity(0.9),
                            )
                          : Icon(
                              Icons.play_arrow,
                              color: Colors.white.withOpacity(0.9),
                            ),
                    ),
                  ),
                );
              }),
      bottomNavigationBar: Obx(
        () => TweenAnimationBuilder<Offset>(
            tween: Tween<Offset>(
                begin: Offset(0, 100),
                end: Offset(0, _audioPlayerController.isPlaing ? 0 : 100)),
            duration: Duration(milliseconds: 500),
            child: AnimatedContainer(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 82, 82, 82),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10))),
              height: 80,
              child: Obx(() {
                return Row(
                    // mainAxisAlignment: MainAxisAlignment.,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Color(0xff1c1c1c),
                              builder: (context) {
                                return detailSheet(context);
                              });
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(),
                          height: 60,
                          width: 60,
                          child: Icon(
                            Icons.music_note,
                            color: AppColors.bluewhite,
                          ),
                          // child: Transform.scale(
                          //   scale: 1.3,
                          //   child: Image.asset(
                          //     AppImages.musicwawe,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),

                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                child: Text(
                              _audioPlayerController.playingnow.displayName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: AppTextStyles.p2
                                  .copyWith(color: Colors.white),
                            )),
                            Container(
                                height: 30,
                                width: double.infinity,
                                child: Obx(
                                  () => ProgressBar(
                                    timeLabelTextStyle:
                                        AppTextStyles.p1.copyWith(fontSize: 10),

                                    baseBarColor:
                                        AppColors.grey.withOpacity(0.3),
                                    progressBarColor: AppColors.white,
                                    thumbGlowColor: Colors.transparent,
                                    thumbColor: Colors.transparent,
                                    timeLabelPadding: 0,
                                    timeLabelLocation: TimeLabelLocation.above,
                                    timeLabelType: TimeLabelType.remainingTime,
                                    onSeek: (v) async {
                                      await _player.seek(v);
                                    },
                                    // onDragStart: (v) async {
                                    //   await _player.seek(v.timeStamp);
                                    // },
                                    onDragUpdate: (v) async {
                                      await _player.seek(v.timeStamp);
                                    },
                                    progress: Duration(
                                        seconds: _audioPlayerController
                                            .currentPosition),
                                    total: Duration(
                                        seconds: _audioPlayerController
                                            .totalDuration),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      //

                      Obx(
                        () => InkWell(
                          onTap: () async {
                            if (_audioPlayerController.playerSate ==
                                PlayerState.playing) {
                              await _player.pause();
                            } else if (_audioPlayerController.playerSate ==
                                PlayerState.paused) {
                              await _player.resume();
                            }
                          },
                          child: Container(
                              width: 50,
                              height: 50,
                              child: _audioPlayerController.playerSate ==
                                      PlayerState.playing
                                  ? Icon(
                                      Icons.pause_rounded,
                                      color: AppColors.grey,
                                    )
                                  : Icon(
                                      Icons.play_arrow,
                                      color: AppColors.grey,
                                    )),
                        ),
                      ),
                    ]);
              }),
            ),
            builder: (context, ani, child) {
              return Transform.translate(offset: ani, child: child);
            }),
      ),
    );
  }

  Widget detailSheet(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          SizedBox(height: 50),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.bluewhite,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: Obx(() {
              return Column(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Text(
                          _audioPlayerController.playingnow.displayName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.h3_regular
                              .copyWith(color: Colors.white),
                        )),
                    Spacer(),
                    Container(
                      child: Icon(
                        Icons.music_note,
                        size: 200,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: 30,
                            width: double.infinity,
                            child: Obx(
                              () => ProgressBar(
                                barHeight: 10,
                                timeLabelTextStyle:
                                    AppTextStyles.p1.copyWith(fontSize: 14),
                                baseBarColor: AppColors.grey.withOpacity(0.3),
                                progressBarColor: AppColors.white,
                                thumbGlowColor: Colors.transparent,
                                thumbColor: Colors.transparent,
                                timeLabelPadding: 0,
                                timeLabelLocation: TimeLabelLocation.above,
                                timeLabelType: TimeLabelType.remainingTime,
                                onSeek: (v) async {
                                  await _player.seek(v);
                                },
                                onDragStart: (v) async {
                                  await _player.seek(v.timeStamp);
                                },
                                onDragUpdate: (v) async {
                                  await _player.seek(v.timeStamp);
                                },
                                progress: Duration(
                                    seconds:
                                        _audioPlayerController.currentPosition),
                                total: Duration(
                                    seconds:
                                        _audioPlayerController.totalDuration),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            _player.setSourceBytes(File(_audioPlayerController
                                    .audioFilesList[
                                        _audioPlayerController.plainindex - 1]
                                    .data)
                                .readAsBytesSync());

                            _audioPlayerController.plaingNowSet =
                                _audioPlayerController.audioFilesList[
                                    _audioPlayerController.plainindex - 1];

                            _audioPlayerController.chngeIndex =
                                _audioPlayerController.plainindex - 1;
                          },
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            color: AppColors.white,
                            size: 40,
                          ),
                        ),
                        Obx(
                          () => InkWell(
                            onTap: () async {
                              if (_audioPlayerController.playerSate ==
                                  PlayerState.playing) {
                                await _player.pause();
                              } else if (_audioPlayerController.playerSate ==
                                  PlayerState.paused) {
                                await _player.resume();
                              }
                            },
                            child: Container(
                                width: 50,
                                height: 50,
                                child: _audioPlayerController.playerSate ==
                                        PlayerState.playing
                                    ? Icon(
                                        Icons.pause_rounded,
                                        size: 60,
                                        color: AppColors.grey,
                                      )
                                    : Icon(
                                        Icons.play_arrow_rounded,
                                        size: 60,
                                        color: AppColors.grey,
                                      )),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _player.setSourceBytes(File(_audioPlayerController
                                    .audioFilesList[
                                        _audioPlayerController.plainindex - 1]
                                    .data)
                                .readAsBytesSync());

                            _audioPlayerController.plaingNowSet =
                                _audioPlayerController.audioFilesList[
                                    _audioPlayerController.plainindex - 1];

                            _audioPlayerController.chngeIndex =
                                _audioPlayerController.plainindex - 1;
                          },
                          icon: Icon(
                            Icons.skip_next_rounded,
                            color: AppColors.white,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ]);
            }),
          ),
        ]),
      ),
    );
  }
}
