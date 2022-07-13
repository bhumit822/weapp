// import 'dart:developer';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:video_thumbnail/video_thumbnail.dart' as th;
// import 'package:weapp/Screens/week7/imagepickerCamera/defaultCameraHelper.dart';
// import 'package:weapp/main.dart';

// class CameraHelper extends SuperController {
//   RxInt selIndex = 0.obs;
//   RxDouble visibility = 0.0.obs;
//   RxBool isVidep = false.obs;
//   RxBool isVideoIntialized = false.obs;

//   List<Map<String, dynamic>> flasmodes = [
//     {'flashMode': FlashMode.always, 'icon': Icons.flash_on},
//     {'flashMode': FlashMode.auto, 'icon': Icons.flash_auto},
//     {'flashMode': FlashMode.off, 'icon': Icons.flash_off},
//     {'flashMode': FlashMode.torch, 'icon': Icons.flashlight_on},
//   ];

//   Rx<FlashMode> flass = FlashMode.off.obs;

//   RxMap<String, dynamic> activeFlashMode =
//       {'flashMode': FlashMode.off, 'icon': Icons.flash_off}.obs;

//   get selIndexget => selIndex.value;
//   PageController? pageController;
//   initPageController() async {
//     pageController = PageController(initialPage: selIndex.value);
//   }

//   CameraController? camera;
//   RxList<FileModel> files = <FileModel>[].obs;
//   RxBool isCameraInitialized = false.obs;
//   Rx<CameraLensDirection> lensDirection = CameraLensDirection.front.obs;

//   RxDouble zoomLevel = 1.0.obs;
//   RxDouble exposureLevelinitial = 0.0.obs;
//   RxDouble exposureLevelmax = 1.0.obs;
//   RxDouble exposureLevelmin = 0.0.obs;

//   RxBool isRecording = false.obs;
//   RxInt cameraMode = 0.obs;

//   initializeCamera(CameraDescription description) async {
//     try {
//       CameraController? oldCameraController = camera;
//       isCameraInitialized.value = false;
//       CameraController? newCameraController = CameraController(
//           description, ResolutionPreset.max,
//           imageFormatGroup: ImageFormatGroup.jpeg, enableAudio: true);

//       if (oldCameraController != null) {
//         await oldCameraController.dispose();
//       }
//       camera = newCameraController;
//       await newCameraController.initialize().then((value) {
//         isCameraInitialized.value = true;
//         lensDirection.value = camera!.description.lensDirection;

//         camera?.setExposureMode(ExposureMode.auto);
//       });
//       // camera?.description.lensDirection;
//       // log('===================${camera!.value.}');

//       log('===================${newCameraController.value.previewSize!.width}');

//       newCameraController.addListener(() async {
//         log("hello");
//         exposureLevelmax.value =
//             await newCameraController.getMaxExposureOffset();
//         exposureLevelmin.value =
//             await newCameraController.getMinExposureOffset();
//       });
//     } catch (e) {
//       log("camera error ===================== $e");
//     }
//   }

//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///Zoom Camera
//   zoomCamera(double value) async {
//     zoomLevel.value = value;
//     await camera?.setZoomLevel(zoomLevel.value);
//   }

//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///exposure of camera
//   cameraExposure(double value) {
//     exposureLevelinitial.value = value;
//     camera?.setExposureOffset(exposureLevelinitial.value);
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     switch (state) {
//       case AppLifecycleState.resumed:
//         onResumed();
//         break;
//       case AppLifecycleState.inactive:
//         onInactive();
//         break;
//       case AppLifecycleState.paused:
//         onPaused();
//         break;
//       case AppLifecycleState.detached:
//         onDetached();
//         break;
//     }
//   }

//   // appLifeCycleObserver(AppLifecycleState state) async {
//   //   final CameraController? cameraController = camera;

//   //   // App state changed before we got the chance to initialize.
//   //   if (cameraController == null || !cameraController.value.isInitialized) {
//   //     return;
//   //   }

//   //   if (state == AppLifecycleState.inactive ||
//   //       state == AppLifecycleState.paused) {
//   //     // Free up memory when camera not active
//   //     isCameraInitialized.value = false;
//   //     cameraController.dispose();
//   //     log("message");
//   //   } else if (state == AppLifecycleState.resumed) {
//   //     // Reinitialize the camera with same properties
//   //     initializeCamera(cameras![1]);
//   //     log("message================");
//   //   }
//   // }

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     getAllFilesInFolder();
//     initializeCamera(cameras![0]);
//     // camera?.addListener(() async {
//     //   log("hello");
//     //   if (camera != null) {
//     //     exposureLevelmax.value = await camera!.getMaxExposureOffset();
//     //     exposureLevelmin.value = await camera!.getMinExposureOffset();
//     //   }
//     // });
//   }

//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///get all files from folder
//   getAllFilesInFolder() async {
//     log("message-----------------------------======================----------------^^^^^^^^^^^^^^^^^^^^^6");
//     PermissionStatus permissionResult = await Permission.storage.request();
//     PermissionStatus permissionResult2 =
//         await Permission.manageExternalStorage.request();

//     final mypath =
//         await Directory("/storage/emulated/0/WeAppPhoto/").listSync();

//     mypath.forEach((element) async {
//       final d = FileStat.statSync(element.path);
//       log(d.modified.toString());
//       final type = element.path.split(".").last == 'jpg' ? "image" : 'video';
//       if (type == 'video') {
//         final _thumb = await getVideoFilethumb(File(element.path));
//         files.add(FileModel(
//             file: File(element.path),
//             path: element.path,
//             type: type,
//             Created: d.modified,
//             thumbnail: _thumb));
//       } else {
//         files.add(FileModel(
//           file: File(element.path),
//           path: element.path,
//           type: type,
//           Created: d.modified,
//         ));
//       }
//     });
//     files.sort(
//       (a, b) => a.Created!.compareTo(b.Created!),
//     );
//     files.refresh();
//   }

//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///click Photo
//   ///
//   RxBool clickingImage = false.obs;
//   clickPhoto() async {
//     clickingImage.value = true;
//     final _photo = await camera?.takePicture();
//     if (_photo != null) {
//       final File _photoFile = File(_photo.path);
//       PermissionStatus permissionResult = await Permission.storage.request();
//       final directory = await getExternalStorageDirectory();

//       Directory mypath = await Directory("/storage/emulated/0/WeAppPhoto/");

//       if (await mypath.exists()) {
//         mypath = mypath;
//       } else {
//         if (permissionResult == PermissionStatus.granted) {
//           //   Directory _appFile = Directory(_storageInfo[0].rootDir + '/MyTestFOlder');
//           // _appFile.create();
//           await new Directory("/storage/emulated/0/WeAppPhoto/")
//               .create(recursive: true)
//               // The created directory is returned as a Future.
//               .then((Directory directory) {
//             mypath = directory;
//           });
//         }
//       }

//       try {
//         final _file = File(mypath.path + _photoFile.path.split("/").last);
//         // final _file = File("${mypath.path}${_clickedmage.name}");

//         final addFile =
//             await _file.writeAsBytes(await _photoFile.readAsBytes());

//         clickingImage.value = false;
//         final type = addFile.path.split(".").last == 'jpg' ? "image" : 'video';

//         files.add(FileModel(
//           file: _file,
//           path: _file.path,
//           type: type,
//         ));

//         files.refresh();
//       } catch (e) {
//         log("SaveFile Error ===============$e");
//       }
//     }
//   }

//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///setfocus on touch
//   void onViewFinderTap(
//       TapDownDetails details, BoxConstraints constraints) async {
//     if (camera == null) {
//       return;
//     }

//     // final CameraController cameraController = camera!;

//     final Offset offset = Offset(
//       details.localPosition.dx / constraints.maxWidth,
//       details.localPosition.dy / constraints.maxHeight,
//     );
//     // camera?.setFlashMode(FlashMode.off);
//     await camera!.setFocusMode(FocusMode.locked);

//     log(offset.toString());
//     camera?.setExposurePoint(offset);
//     await camera?.setFocusPoint(offset);

//     // exposureLevelinitial.value =cameraController.
//     //   ;
//   }

//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///Record Video

//   videoRecording() async {
//     if (!camera!.value.isRecordingVideo) {
//       await camera?.startVideoRecording();
//       isRecording.value = true;
//     } else {
//       final _videofile = await camera?.stopVideoRecording();
//       isRecording.value = false;

//       if (_videofile != null) {
//         final _fileV = File(_videofile.path);

//         PermissionStatus permissionResult = await Permission.storage.request();
//         final directory = await getExternalStorageDirectory();

//         Directory mypath = await Directory("/storage/emulated/0/WeAppPhoto/");

//         if (await mypath.exists()) {
//           mypath = mypath;
//         } else {
//           if (permissionResult == PermissionStatus.granted) {
//             //   Directory _appFile = Directory(_storageInfo[0].rootDir + '/MyTestFOlder');
//             // _appFile.create();
//             await new Directory("/storage/emulated/0/WeAppPhoto/")
//                 .create(recursive: true)
//                 // The created directory is returned as a Future.
//                 .then((Directory directory) {
//               mypath = directory;
//             });
//           }
//         }

//         try {
//           final _file = File(mypath.path + _fileV.path.split("/").last);
//           // final _file = File("${mypath.path}${_clickedmage.name}");

//           final addFile = await _file.writeAsBytes(await _fileV.readAsBytes());

//           final type =
//               addFile.path.split(".").last == 'jpg' ? "image" : 'video';

//           final _thumb = await getVideoFilethumb(addFile);
//           files.add(FileModel(
//               file: addFile,
//               path: addFile.path,
//               type: type,
//               thumbnail: _thumb));

//           files.refresh();
//         } catch (e) {
//           log("SaveFile Error ===============$e");
//         }
//       }
//     }
//   }

//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///
//   ///create thumbnail of video file
//   Future<String> getVideoFilethumb(File file) async {
//     final String? uint8list = await th.VideoThumbnail.thumbnailFile(
//       video: file.path,
//       imageFormat: th.ImageFormat.JPEG,
//       thumbnailPath: (await getTemporaryDirectory()).path,
//       maxWidth: 500,
//       maxHeight:
//           500, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//       quality: 50,
//     );

//     final res = uint8list!;

//     return res;
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     camera?.dispose();
//   }

//   @override
//   void onClose() {
//     // TODO: implement onClose
//     super.onClose();
//     camera?.dispose();
//   }

//   @override
//   void onResumed() {
//     initializeCamera(cameras![1]);

//     log("message================");
//     log("============================");
//   }

//   @override
//   void onDetached() {
//     // TODO: implement onDetached
//   }

//   @override
//   void onInactive() {
//     isCameraInitialized.value = false;
//     camera?.dispose();
//     log("message");
//     log("2============================");
//   }

//   @override
//   void onPaused() {
//     isCameraInitialized.value = false;
//     camera?.dispose();
//     log("message");
//     log("1============================");
//   }
// }

// //   CameraController? camera;
// //   RxList<CameraDescription> cameras = <CameraDescription>[].obs;
// //   RxDouble aspectRatio = 0.0.obs;
// //   RxBool iscameraInitialized = false.obs;
// //   @override
// //   void onInit() {
// //     // TODO: implement onInit
// //     super.onInit();

// //     getCameras();
// //   }

// //   getCameraLst() async {}

// //   Future getCameras() async {
// //     cameras.value = await availableCameras();

// //     cameras.refresh();
// //     // log("==================================\n\n\n\n\nn\n\n\n\n\n\n\n\n${cameras.toString()}");
// //     // camera = CameraController(cameras[1], ResolutionPreset.ultraHigh);
// //     // await camera!
// //     //     .initialize()
// //     //     .then((value) => camera!.setFlashMode(FlashMode.off));
// //     // iscameraInitialized.value = true;
// //     // aspectRatio.value = camera!.value.previewSize!.aspectRatio;

// //     onNewCameraSelected(cameras.first);
// //     // log("aspectRAtio======== ${camera!.value.aspectRatio}");
// //     // log("height======== ${camera!.value.previewSize!.height}");
// //     // log("width======== ${camera!.value.previewSize!.width}");
// //     // log("width======== ${camera!.value.deviceOrientation}");
// //     // log("width======== ${camera!.}");
// //   }

// //   appLifeCycleObserver(AppLifecycleState state) async {
// //     final CameraController? cameraController = camera;

// //     // App state changed before we got the chance to initialize.
// //     if (cameraController == null || !cameraController.value.isInitialized) {
// //       return;
// //     }

// //     if (state == AppLifecycleState.inactive) {
// //       // Free up memory when camera not active
// //       iscameraInitialized.value = false;
// //       cameraController.dispose();
// //     } else if (state == AppLifecycleState.resumed) {
// //       // Reinitialize the camera with same properties
// //       onNewCameraSelected(cameraController.description);
// //     }
// //   }

// //   void onNewCameraSelected(CameraDescription cameraDescription) async {
// //     final previousCameraController = camera;
// //     // Instantiating the camera controller
// //     final CameraController cameraController = CameraController(
// //       cameraDescription,
// //       ResolutionPreset.max,
// //       imageFormatGroup: ImageFormatGroup.jpeg,
// //     );

// //     // Dispose the previous controller
// //     await previousCameraController?.dispose();

// //     // Replace with the new controller

// //     camera = cameraController;

// //     // Update UI if controller updated
// //     cameraController.addListener(() {});

// //     // Initialize controller
// //     try {
// //       await cameraController
// //           .initialize()
// //           .then((value) => iscameraInitialized.value = true);
// //     } on CameraException catch (e) {
// //       print('Error initializing camera: $e');
// //     }

// //     // Update the Boolean

// //     //  _isCameraInitialized = controller!.value.isInitialized;
// //   }

// //   @override
// //   void dispose() {
// //     camera?.dispose();
// //     super.dispose();
// //   }
// // }

// //  onPressed: () async {
// //                                 try {
// //                                   cam.camera!.value.copyWith(
// //                                       previewSize: Size(
// //                                           MediaQuery.of(context).size.width,
// //                                           MediaQuery.of(context).size.height));
// //                                   final picture =
// //                                       await cam.camera?.takePicture();
// //                                   log('${picture!.path}');
// //                                   PermissionStatus permissionResult =
// //                                       await Permission.storage.request();
// //                                   final directory =
// //                                       await getExternalStorageDirectory();

// //                                   Directory mypath = await Directory(
// //                                       "/storage/emulated/0/WeAppPhoto/");

// //                                   if (await mypath.exists()) {
// //                                     mypath = mypath;
// //                                   } else {
// //                                     if (permissionResult ==
// //                                         PermissionStatus.granted) {
// //                                       //   Directory _appFile = Directory(_storageInfo[0].rootDir + '/MyTestFOlder');
// //                                       // _appFile.create();
// //                                       await new Directory(
// //                                               "/storage/emulated/0/WeAppPhoto/")
// //                                           .create(recursive: true)
// //                                           // The created directory is returned as a Future.
// //                                           .then((Directory directory) {
// //                                         mypath = directory;
// //                                       });
// //                                     }
// //                                   }

// //                                   if (await mypath.exists()) {
// //                                     File _image = File(mypath.path +
// //                                         "/" +
// //                                         picture.path.split("/").last);
// //                                     _image.writeAsBytes(
// //                                         await picture.readAsBytes());
// //                                   }

// //                                   log("${directory!.path}");
// //                                 } catch (e) {
// //                                   log("TAcke Pictyeer Error============ $e");
// //                                 }
// //                               },
