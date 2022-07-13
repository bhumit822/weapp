// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';

// class DefaulCameraHelper extends GetxController {
//   Rx<File> image = File("").obs;
//   Rx<File> video = File("").obs;

//   RxDouble visibility = 0.0.obs;
//   RxBool isVidep = false.obs;
//   RxBool isVideoIntialized = false.obs;

//   RxList<FileModel> files = <FileModel>[].obs;
//   RxDouble scall = 1.0.obs;
//   RxInt selIndex = 0.obs;
//   Rx<FileModel> _selectedFile =
//       FileModel(file: File(""), path: "", type: "").obs;

//   get selIndexget => selIndex.value;

//   PageController? pageController;

//   RxDouble start = 0.0.obs;

//   initPageController() async {
//     pageController = PageController(initialPage: selIndex.value);
//   }

//   get getFiles => files;

//   shootVideo() async {
//     try {
//       final _shootedVideo =
//           await ImagePicker.platform.getVideo(source: ImageSource.camera);
//       video.value = File(_shootedVideo!.path);
//       PermissionStatus permissionResult = await Permission.storage.request();
//       PermissionStatus permissionResult2 =
//           await Permission.manageExternalStorage.request();
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
//         final _file = File("${mypath.path}/${_shootedVideo.name}");
//         final addFile = await _file.writeAsBytes(video.value.readAsBytesSync());

//         final type = addFile.path.split(".").last == 'jpg' ? "image" : 'video';
//         final _thumb = await getVideoFilethumb(addFile);
//         files.add(FileModel(
//             file: addFile, path: addFile.path, type: type, thumbnail: _thumb));
//         files.sort(
//           (a, b) => a.Created!.compareTo(b.Created!),
//         );
//         files.refresh();
//       } catch (e) {
//         log("SaveFile VIdeo Error ===============$e");
//       }
//     } catch (e) {
//       log("shoot video Error ${e}");
//     }
//   }

//   clickImage() async {
//     try {
//       final _clickedmage =
//           await ImagePicker.platform.getImage(source: ImageSource.camera);

//       image.value = File(_clickedmage!.path);
//       log(image.value.path);
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
//         final _file = File(mypath.path + _clickedmage.path.split("/").last);
//         // final _file = File("${mypath.path}${_clickedmage.name}");

//         final addFile =
//             await _file.writeAsBytes(await image.value.readAsBytes());

//         final type = addFile.path.split(".").last == 'jpg' ? "image" : 'video';

//         files.add(FileModel(
//           file: _file,
//           path: _file.path,
//           type: type,
//         ));
//         files.sort(
//           (a, b) => a.Created!.compareTo(b.Created!),
//         );
//         files.refresh();
//       } catch (e) {
//         log("SaveFile Error ===============$e");
//       }
//     } catch (e) {
//       log("clipimage -------------------$e");
//     }
//   }

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
//       (a, b) => b.Created!.compareTo(a.Created!),
//     );
//     files.refresh();
//   }

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     log("initialized ---------------------");
//     getAllFilesInFolder();
//   }

//   Future<String> getVideoFilethumb(File file) async {
//     final String? uint8list = await VideoThumbnail.thumbnailFile(
//       video: file.path,
//       imageFormat: ImageFormat.WEBP,
//       thumbnailPath: (await getTemporaryDirectory()).path,
//       maxWidth: 500,
//       maxHeight:
//           500, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//       quality: 50,
//     );

//     final res = uint8list!;

//     return res;
//   }
// }

// class FileModel {
//   File file;
//   String path;
//   String type;
//   String? thumbnail;
//   DateTime? Created;

//   FileModel(
//       {required this.file,
//       required this.path,
//       required this.type,
//       this.thumbnail,
//       this.Created});
// }
