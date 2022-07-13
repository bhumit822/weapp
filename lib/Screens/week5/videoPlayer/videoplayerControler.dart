import 'dart:developer';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:weapp/Screens/week5/videoPlayer/filelistScreen.dart';
import 'package:weapp/Screens/week5/videoPlayer/videoscreen.dart';
import 'package:weapp/Screens/week5/videoPlayer/vlcVideoscreen.dart';

///
///
///
///
///

// class VideoDEmoController extends GetxController {
//   RxList<AssetPathEntity> folders = <AssetPathEntity>[].obs;
//   RxList<AssetEntity> files = <AssetEntity>[].obs;
//   Rx<Duration> position = Duration(seconds: 0).obs;
//   Rx<Duration> totalDuration = Duration(seconds: 0).obs;

//   RxBool isPlaying = false.obs;
//   RxBool showContolls = true.obs;
//   RxInt fileIndex = 0.obs;
//   Rx<File> currentfile = File("").obs;
//   RxInt start = 0.obs;
//   RxInt end = 0.obs;

//   set setfirstfile(File file) {
//     currentfile.value = file;
//   }

//   late VlcPlayerController vlc;

//   vlcplay() async {
//     try {
//       vlc = VlcPlayerController.file(currentfile.value, autoPlay: false,
//           onInit: () {
//         vlc.play();
//       },
//           options: VlcPlayerOptions(
//               advanced:
//                   VlcAdvancedOptions([VlcAdvancedOptions.fileCaching(5000)])));
//       // final heit=vlc.

//       // var audioTracks = await vlc.getAudioTracks();

//       // log(audioTracks.toString());

//       await Get.to(() => VlcVideoScreen())!.whenComplete(() {
//         vlc.pause();
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   late VideoPlayerController vController;

//   playVideo(File file) async {
//     // final fff = await vlc.getAudioTracks();
//     // print(fff);
//     // if (vlc.value.aspectRatio >= 1) {
//     //   await SystemChrome.setPreferredOrientations(
//     //       [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
//     // }
//     // await SystemChrome.setEnabledSystemUIMode(
//     //   SystemUiMode.immersiveSticky,
//     // );

//     // log(vlc.value.size.aspectRatio.toString());

//     // await Get.to(() => VlcVideoScreen())!.then((value) async {
//     //   await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     //   SystemChrome.setPreferredOrientations([
//     //     DeviceOrientation.portraitUp,
//     //   ]);
//     // disposedd();
//     // });
//     // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//   }

//   vlcListner() async {
//     // final a = await vlc.getVideoAspectRatio();

//     // print(
//     // "object===========================================================================${a}");
//   }

// /*

// */
//   ///Get folders with video files
//   getFolderList() async {
//     await PhotoManager.requestPermissionExtend();
//     folders.value =
//         await PhotoManager.getAssetPathList(type: RequestType.video);
//     folders.refresh();
//   }

// /*

// */

// /*

//   /// get video files in folder

// */
//   getFileList(int index) async {
//     final _folder = folders[index];
//     final _files =
//         await _folder.getAssetListRange(start: 0, end: _folder.assetCount);
//     files.value = _files;
//     files.refresh();

//     Get.to(() => VideoListScreen());
//   }

// /*

// */

//   @override
//   void onInit() {
//     super.onInit();
//     getFolderList();

//     // vlc.initialize();
//   }

//   @override
//   void onClose() {
//     // TODO: implement onClose
//     super.onClose();
//     // disposedd();
//   }
// }

///
/////
///
///
///
///
///
///
///
///
///
///
///
///

class VideoDEmoController extends GetxController {
  RxString folderName = "".obs;
  RxList<AssetPathEntity> folders = <AssetPathEntity>[].obs;
  RxList<AssetEntity> files = <AssetEntity>[].obs;
  Rx<Duration> position = Duration(seconds: 0).obs;
  Rx<Duration> totalDuration = Duration(seconds: 0).obs;

  RxBool isPlaying = false.obs;
  RxBool showContolls = true.obs;
  RxInt fileIndex = 0.obs;

  RxInt start = 0.obs;
  RxInt end = 0.obs;

  RxBool isLooping = false.obs;
  RxBool isMute = false.obs;

  VideoPlayerController? vController;
  // late ChewieController chewie;

/*






*/
  ///Get folders with video files
  getFolderList() async {
    await PhotoManager.requestPermissionExtend();
    folders.value =
        await PhotoManager.getAssetPathList(type: RequestType.video);
    folders.refresh();
  }

/*






*/
  /// get video files in folder
  getFileList(int index) async {
    final _folder = folders[index];
    final _files =
        await _folder.getAssetListRange(start: 0, end: _folder.assetCount);
    files.value = _files;
    files.refresh();

    Get.to(() => VideoListScreen());
  }

/*






*/
  bool _disposed = false;

  RxBool isFirstScreen = false.obs;
  plaay(int index) async {
    isPlaying.value = false;
    log("file INdex in plaaay method===========================${fileIndex.value}");
    final _file = await files[index].file;
    print("============================${_file!.path}");

    final controller = VideoPlayerController.file(_file);
    final old = vController;
    vController = controller;
    if (old != null) {
      old.pause();
      old.removeListener(plaayListner);
    }
    await controller.initialize().then((value) async {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky,
      );
      if (controller.value.aspectRatio > 1) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });

    controller.setLooping(true);

    old?.dispose();
    controller.addListener(plaayListner);
    controller.play();
    isPlaying.value = true;

    if (isFirstScreen.value) {
      await Get.to(() => VideoScreen())?.then((value) async {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      });
    } else {
      // await Get.off(() => VideoScreen())?.then((value) async {
      //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      //       overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      //   SystemChrome.setPreferredOrientations([
      //     DeviceOrientation.portraitUp,
      //     DeviceOrientation.portraitDown,
      //   ]);
      // });
    }
  }

  plaayListner() {
    final controller = vController;

    totalDuration.value = controller!.value.duration;
    position.value = controller.value.position;
    isLooping.value = controller.value.isLooping;
    isPlaying.value = controller.value.isPlaying;

    if (controller.value.position ==
        Duration(seconds: 0, minutes: 0, hours: 0)) {
      log('video Started');
    }

    if (controller.value.position.inMicroseconds ==
            controller.value.duration.inMicroseconds &&
        !controller.value.isLooping &&
        fileIndex.value < files.length &&
        controller.value.duration !=
            Duration(seconds: 0, minutes: 0, hours: 0, milliseconds: 0)) {
      Future.delayed(
          Duration(
            milliseconds: 400,
          ), () {
        if (fileIndex < (files.length - 1)) {
          plaay(++fileIndex.value);
          log("next");
        } else {
          // controller.pause();
          // controller.dispose();
          // Get.back();
          // controller.pause();
        }
      });
    }

    // log("Position========${controller.value.position.inMilliseconds}_______________________${controller.value.duration.inMilliseconds}");
    // if (controller.value.isPlaying &&
    //     controller.value.isInitialized &&
    //     (controller.value.position == controller.value.duration)) {
    //   log("total list lenghth ==========${files.length}");

    //   log('playing===========================${controller.value.isPlaying}');
    //   // Future.delayed(Duration(milliseconds: 1200), () {
    //   //   fileIndex.value++;
    //   //   vController.pause();
    //   //   log(fileIndex.value.toString());
    //   //   fileIndex.value;
    //   //   controller.removeListener(plaayListner);
    //   // });
    //   // plaay();

    // }
  }

  nextAndprev(int index) {
    if (index >= 0 && index <= files.length - 1) {
      fileIndex.value = index;
      plaay(index);
    } else {
      Fluttertoast.showToast(msg: "No Video");
    }
  }

  // playVideo(File file) async {
  //   vController = VideoPlayerController.file(file,
  //       videoPlayerOptions: VideoPlayerOptions(
  //           allowBackgroundPlayback: true, mixWithOthers: false));
  //   await vController.initialize();

  //   // log(vController.value.aspectRatio.toString());

  //   SystemChrome.setEnabledSystemUIMode(
  //     SystemUiMode.immersiveSticky,
  //   );

  //   if (vController.value.aspectRatio > 1) {
  //     SystemChrome.setPreferredOrientations([
  //       DeviceOrientation.landscapeRight,
  //       DeviceOrientation.landscapeLeft,
  //     ]);
  //   }
  //   totalDuration.value = vController.value.duration;
  //   vController.addListener(videoListener);
  //   // vController.removeListener(videoListener);
  //   await vController.play();
  //   await Get.to(() => VideoScreen())?.then((value) async {
  //     await vController.pause();
  //     vController.removeListener(videoListener);

  //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //         overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  //     SystemChrome.setPreferredOrientations([
  //       DeviceOrientation.portraitUp,
  //       DeviceOrientation.portraitDown,
  //     ]);
  //   });
  // }

  // plaNext() async {
  //   if (fileIndex.value < files.length - 1) {
  //     final next = await files[fileIndex.value + 1].file;
  //   }
  // }

  // videoListener() async {
  //   position.value = vController.value.position;

  //   vController.value.isPlaying
  //       ? isPlaying.value = true
  //       : isPlaying.value = false;
  //   if (vController.value.position.compareTo(vController.value.duration) == 0 &&
  //       fileIndex.value < files.length) {}

  //   // vController.removeListener(videoListener);
  // }

  disposeController() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // await vController?.pause();
    // await vController?.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    getFolderList();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    disposeController();

    // vController?.removeListener(plaayListner);
    // vController?.dispose();
  }
}
