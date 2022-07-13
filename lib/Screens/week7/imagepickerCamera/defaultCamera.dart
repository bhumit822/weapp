// import 'dart:developer';
// import 'dart:io';

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
// import 'package:visibility_detector/visibility_detector.dart';
// import 'package:weapp/Screens/week7/imagepickerCamera/defaultCameraHelper.dart';
// import 'package:weapp/Screens/week7/imagepickerCamera/viewPage.dart';

// // class DefaulCameraDemo extends StatefulWidget {
// //   const DefaulCameraDemo({Key? key}) : super(key: key);

// //   @override
// //   State<DefaulCameraDemo> createState() => _DefaulCameraDemoState();
// // }

// class DefaulCameraDemo extends StatelessWidget {
//   DefaulCameraHelper cam = Get.put(DefaulCameraHelper());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Obx(() {
//           log("message---------------->>>>>>>>>>>>>>>>>>>>>>>>>>-------------------------");
//           return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
//               itemCount: cam.getFiles.length,
//               itemBuilder: (contex, index) {
//                 if (cam.files[index].type == 'image') {
//                   return InkWell(
//                     onTap: () {
//                       cam.selIndex.value = index;
//                       Navigator.of(context)
//                           .push(HeroDialogRoute(builder: (context) {
//                         return GalleryViewScreen();
//                       }));

//                       // Get.to(() => HeroDialogRoute(builder: (context) {
//                       //       return Container(
//                       //         color: Colors.red,
//                       //         height: 100,
//                       //         width: 100,
//                       //       );
//                       //     }));
//                       // Get.to(() => GalleryViewScreen());
//                     },
//                     child: Container(
//                         child: Hero(
//                       tag: cam.files[index].file.path,
//                       child: Image.file(
//                         cam.getFiles[index].file,
//                         fit: BoxFit.cover,
//                         filterQuality: FilterQuality.high,
//                         alignment: Alignment.center,
//                       ),
//                     )),
//                   );
//                 } else {
//                   return InkWell(
//                     onTap: () async {
//                       try {
//                         cam.scall.value = 1.0;
//                         cam.selIndex.value = index;
//                         await Navigator.of(context)
//                             .push(HeroDialogRoute(builder: (context) {
//                           return GalleryViewScreen();
//                         }));
//                       } catch (e) {}
//                     },
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Container(
//                             child: Hero(
//                           tag: cam.files[index].file.path,
//                           child: Image.file(
//                             File(cam.files[index].thumbnail!),
//                             fit: BoxFit.cover,
//                             // filterQuality: FilterQuality.,
//                             alignment: Alignment.center,
//                           ),
//                         )),
//                         Container(
//                           decoration: BoxDecoration(color: Colors.black26),
//                         ),
//                         Icon(
//                           Icons.play_circle_outline,
//                           size: 40,
//                           color: Colors.white,
//                         )
//                       ],
//                     ),
//                   );
//                 }
//               });
//         }),
//       ),
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               cam.clickImage();
//             },
//             child: Icon(Icons.image),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           FloatingActionButton(
//             heroTag: "video",
//             onPressed: () {
//               cam.shootVideo();
//             },
//             child: Icon(Icons.video_camera_back_rounded),
//           )
//         ],
//       ),
//     );
//   }
// }

// class HeroDialogRoute<T> extends PageRoute<T> {
//   HeroDialogRoute({required this.builder}) : super();

//   final WidgetBuilder builder;

//   @override
//   bool get opaque => false;

//   @override
//   bool get barrierDismissible => true;

//   @override
//   Duration get transitionDuration => const Duration(milliseconds: 300);

//   @override
//   bool get maintainState => true;

//   @override
//   Color get barrierColor => Colors.black54;

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     return new FadeTransition(
//         opacity: new CurvedAnimation(parent: animation, curve: Curves.easeOut),
//         child: Material(child: child));
//   }

//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation) {
//     return builder(context);
//   }

//   @override
//   // TODO: implement barrierLabel
//   String? barrierLabel = "check";
// }
