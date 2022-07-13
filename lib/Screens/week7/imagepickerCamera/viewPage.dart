// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:video_player/video_player.dart';
// import 'package:visibility_detector/visibility_detector.dart';
// import 'package:weapp/Screens/week7/imagepickerCamera/defaultCameraHelper.dart';

// class GalleryViewScreen extends StatefulWidget {
//   const GalleryViewScreen({Key? key}) : super(key: key);

//   @override
//   State<GalleryViewScreen> createState() => _GalleryViewScreenState();
// }

// class _GalleryViewScreenState extends State<GalleryViewScreen> {
//   DefaulCameraHelper _cam = Get.find();

//   VideoPlayerController? vVideoController;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _cam.initPageController();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     vVideoController?.pause();
//     vVideoController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.black,
//         body: GestureDetector(
//           onVerticalDragEnd: (v) {
//             // Get.back();
//           },
//           child: Obx(
//             () => PageView(
//               controller: _cam.pageController,
//               onPageChanged: (v) {
//                 // _Video?.pause();
//                 _cam.selIndex.value = v;
//               },
//               children: List.generate(_cam.files.length, (index) {
//                 if (_cam.files[_cam.selIndex.value].type == 'image') {
//                   if (vVideoController != null) {
//                     final _old = vVideoController;
//                     _old?.pause();

//                     // _old?.dispose();
//                     _cam.isVidep.value = false;
//                     _cam.isVideoIntialized.value = false;
//                     log("4===================");
//                   }
//                 } else {}
//                 return _cam.files[index].type == 'image'
//                     ? Material(
//                         color: Colors.black,
//                         child: PhotoViewGallery(
//                           allowImplicitScrolling: true,
//                           enableRotation: true,
//                           scrollPhysics: BouncingScrollPhysics(),
//                           pageOptions: [
//                             PhotoViewGalleryPageOptions(
//                                 maxScale: 2.0,
//                                 minScale: PhotoViewComputedScale.contained,
//                                 imageProvider: FileImage(
//                                     File(_cam.files[index].file.path))),
//                           ],
//                         ),
//                       )
//                     : Material(
//                         color: Colors.black,
//                         child: VisibilityDetector(
//                           onVisibilityChanged: (v) async {
//                             _cam.isVidep.value = false;
//                             _cam.isVideoIntialized.value = false;
//                             _cam.visibility.value = v.visibleFraction;
//                             if (v.visibleFraction == 1) {
//                               log("5===================");
//                               final _old = vVideoController;

//                               final _new = VideoPlayerController.file(
//                                   _cam.files[_cam.selIndex.value].file);
//                               _old?.pause();
//                               if (_old != null) {
//                                 _old.dispose();
//                               }
//                               log("3===================");
//                               vVideoController = _new;
//                               _cam.isVidep.value = true;
//                               await _new.initialize().then((value) =>
//                                   _cam.isVideoIntialized.value = true);
//                             } else {
//                               _cam.visibility.value == 0;
//                               // final _old = _Video;
//                               // _old?.pause();
//                               // _old?.dispose();
//                             }
//                           },
//                           key: ValueKey(_cam.files[index].file.path),
//                           child: InkWell(
//                             onTap: () {
//                               // if (_Video!.value.isPlaying) {
//                               //   _Video!.pause();
//                               // } else {
//                               vVideoController!.play();
//                               // }
//                               log('${vVideoController!.value.size.width}');
//                             },
//                             child: Obx(
//                               () => _cam.visibility.value == 1 &&
//                                       _cam.isVideoIntialized.value
//                                   ? Container(
//                                       key:
//                                           ValueKey(_cam.files[index].file.path),
//                                       height:
//                                           MediaQuery.of(context).size.height,
//                                       width: MediaQuery.of(context).size.width,
//                                       child: FittedBox(
//                                         key: ValueKey(
//                                             _cam.files[index].file.path),
//                                         fit: BoxFit.fitWidth,
//                                         child: SizedBox(
//                                           key: ValueKey(
//                                               _cam.files[index].file.path),
//                                           width: vVideoController!
//                                               .value.size.width,
//                                           height: vVideoController!
//                                               .value.size.height,
//                                           child: AspectRatio(
//                                             key: ValueKey(
//                                                 _cam.files[index].file.path),
//                                             aspectRatio: vVideoController!
//                                                     .value.size.width /
//                                                 vVideoController!
//                                                     .value.size.height,
//                                             child: VideoPlayer(
//                                               vVideoController!,
//                                               key: ValueKey(
//                                                   _cam.files[index].file.path),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Image.file(
//                                       File(
//                                         _cam.files[index].thumbnail!,
//                                       ),
//                                       fit: BoxFit.fitWidth,
//                                     ),
//                             ),
//                           ),
//                         ),
//                       );
//               }),
//             ),
//           ),
//         ));
//   }
// }
