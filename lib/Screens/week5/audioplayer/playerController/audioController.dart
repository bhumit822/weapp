import 'package:audioplayers/audioplayers.dart';

import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerController extends GetxController {
  OnAudioQuery localFiles = OnAudioQuery();
  RxList audioFilesList = <SongModel>[].obs;

  ///player Current state (playing/paused/stoped/resumed)
  Rx<PlayerState> playerSate = PlayerState.completed.obs;
  set setPlayerState(PlayerState state) {
    playerSate.value = state;
  }

  ///Duration of current playing
  final RxInt _totalDuration = 1.obs;
  int get totalDuration => _totalDuration.value;
  set setTotalDuration(int duration) {
    _totalDuration.value = duration;
  }
//
//
//
//
//

  ///Current duration position
  final RxInt _currentPosition = 0.obs;
  int get currentPosition => _currentPosition.value;
  set setCurrentPosition(int duration) {
    _currentPosition.value = duration;
  }
//
//
//
//
//
//

  final _isPlaying = false.obs;
  bool get isPlaing => _isPlaying.value;

//
//
//
//
//
//
//

  Rx<SongModel> _playingNow = SongModel({}).obs;
  SongModel get playingnow => _playingNow.value;
  set plaingNowSet(SongModel model) {
    _playingNow.value = model;
  }

//
//
//
//
//
//
//
  final _playingindex = 0.obs;
  int get plainindex => _playingindex.value;

  ///set new Index While chnge Song
  set chngeIndex(int index) {
    _playingindex.value = index;
  }

  ///set initial Playing index set index > file list length so whene enter to screen first time no element is show as playing
  changePlayingIndex() {
    chngeIndex = audioFilesList.value.length + 1;
  }

//
//
//
//
//
//
//
  set setIsPlaying(bool name) {
    _isPlaying.value = name;
  }

//
//
//
//
//
//
//
//
//

  ///Get Permision if not Available and Get ALL Audio Files On Device
  Future viewPermision() async {
    final _permision = await localFiles.permissionsRequest();

    if (_permision) {
      final _fileList = await localFiles.querySongs();
      audioFilesList.assignAll(_fileList);
      print(audioFilesList.length);

      audioFilesList.refresh();
      changePlayingIndex();
    } else {}
  }

/*



--------------Formate  Duration -------------



*/

  String ConverDuration(int seconds) {
    final int hr = ((seconds ~/ 60) ~/ 60);

    final int min = (seconds ~/ 60);
    final int sec = (seconds % 60);

    // if (hr > 0) {
    return "${hr.toString().padLeft(2, '0')}:${min % 60}:$sec";
    // } else {
    // return "$min:$sec";
    // }
  }
}
