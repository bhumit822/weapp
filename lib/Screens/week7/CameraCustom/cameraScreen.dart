// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';
// import 'package:weapp/Screens/week7/CameraCustom/cameraController.dart';
// import 'package:weapp/Screens/week7/CameraCustom/previewpage.dart';
// import 'package:weapp/Screens/week7/imagepickerCamera/defaultCamera.dart';
// import 'package:weapp/constdata/textstyles.dart';
// import 'package:weapp/main.dart';

// class CameraDemo extends StatefulWidget {
//   const CameraDemo({Key? key}) : super(key: key);

//   @override
//   State<CameraDemo> createState() => _CameraDemoState();
// }

// class _CameraDemoState extends State<CameraDemo> {
//   @override
//   void initState() {
//     super.initState();
//     p.addListener(() {
//       cam.cameraMode.value = p.page!.floor().round();
//       p2.animateToPage(cam.cameraMode.value,
//           duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
//       log(cam.cameraMode.value.toString());
//     });
//     p2.addListener(() {});
//   }

//   CameraHelper cam = Get.put(CameraHelper());

//   PageController p = PageController(viewportFraction: 0.2);
//   PageController p2 = PageController(viewportFraction: 1);
//   List<String> mode = ['Photo', 'Video'];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Obx(() => cam.isCameraInitialized.value
//             ? Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   FittedBox(
//                       fit: BoxFit.fitWidth,
//                       child: SizedBox(
//                           width: cam.camera!.value.previewSize!.height,
//                           height: cam.camera!.value.previewSize!.width,
//                           child: CameraPreview(
//                             cam.camera!,
//                             child: LayoutBuilder(builder: (BuildContext context,
//                                 BoxConstraints constraints) {
//                               return GestureDetector(
//                                 behavior: HitTestBehavior.opaque,
//                                 // onScaleStart: _handleScaleStart,
//                                 // onScaleUpdate: _handleScaleUpdate,
//                                 onTapDown: (TapDownDetails details) =>
//                                     // log("object"),
//                                     cam.onViewFinderTap(details, constraints),
//                               );
//                             }),
//                           ))),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Expanded(
//                         child: Align(
//                           alignment: Alignment(0.9, -0.6),
//                           child: PopupMenuButton(
//                               // color: Colors.transparent,
//                               elevation: 0,
//                               child: Obx(
//                                 () => Icon(
//                                   cam.flasmodes.firstWhere((element) =>
//                                       element['flashMode'] ==
//                                       cam.flass.value)['icon'],
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               onSelected: (Map<String, dynamic> v) async {
//                                 // log("$v");
//                                 // cam.activeFlashMode.value = v;
//                                 await cam.camera?.setFlashMode(v['flashMode']);

//                                 cam.flass.value = cam.camera!.value.flashMode;
//                               },
//                               itemBuilder: (context) => cam.flasmodes
//                                   .map((e) => PopupMenuItem(
//                                       onTap: () async {
//                                         // log(e.runtimeType.toString());
//                                         // cam.activeFlashMode.value = e;
//                                         log("${cam.activeFlashMode}");
//                                       },
//                                       value: e,
//                                       child: Icon(e['icon'])))
//                                   .toList()),
//                         ),
//                       ),
//                       Spacer(),
//                       Align(
//                         alignment: Alignment(0.8, 1),
//                         child: Obx(() => Container(
//                               width: 20,
//                               // padding: EdgeInsets.only(right: 20),
//                               child: SfSlider.vertical(
//                                   min: cam.exposureLevelmin.value,
//                                   max: cam.exposureLevelmax.value,
//                                   value: cam.exposureLevelinitial.value,
//                                   // showLabels: true,
//                                   shouldAlwaysShowTooltip: true,
//                                   onChanged: (v) {
//                                     cam.cameraExposure(v);
//                                   }),
//                             )),
//                       ),
//                       Obx(() => Slider(
//                             label: "Zoom",
//                             value: cam.zoomLevel.value,
//                             onChanged: (v) {
//                               cam.zoomCamera(v);
//                             },
//                             min: 1.0,
//                             max: 2.0,
//                           )),
//                       Container(
//                         width: MediaQuery.of(context).size.width,
//                         child: Container(
//                             alignment: Alignment.center,
//                             height: 30,
//                             width: 100,
//                             clipBehavior: Clip.none,
//                             child: PageView.builder(
//                               controller: p,
//                               clipBehavior: Clip.none,
//                               onPageChanged: (v) {},
//                               scrollDirection: Axis.horizontal,
//                               itemCount: mode.length,
//                               itemBuilder: (context, index) {
//                                 return InkWell(
//                                   onTap: () {
//                                     p.animateToPage(index,
//                                         duration: Duration(milliseconds: 200),
//                                         curve: Curves.fastOutSlowIn);
//                                   },
//                                   child: Container(
//                                       width: 100,
//                                       child: Center(
//                                           child: Text(mode[index],
//                                               style: AppTextStyles.h3_Bold
//                                                   .copyWith(
//                                                       color:
//                                                           AppColors.white)))),
//                                 );
//                               },
//                             )),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Icon(
//                         Icons.circle,
//                         size: 10,
//                         color: Colors.amber,
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(10),
//                         child: Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Container(
//                               height: 70,
//                               width: 70,
//                               child: InkWell(
//                                 onTap: () {
//                                   final x = cam.files.indexOf(cam.files.last);
//                                   cam.selIndex.value = x;
//                                   Navigator.of(context).push(HeroDialogRoute(
//                                     builder: (context) {
//                                       return PreViewScreen();
//                                     },
//                                   ));
//                                 },
//                                 child: Obx(() => cam.files.length > 0
//                                     ? Image.file(
//                                         File(cam.files.last.thumbnail ??
//                                             cam.files.last.file.path),
//                                         fit: BoxFit.cover,
//                                         alignment: Alignment.center,
//                                       )
//                                     : Center(
//                                         child: CircularProgressIndicator(),
//                                       )),
//                               ),
//                             ),
//                             Spacer(),
//                             Container(
//                               height: 70,
//                               width: 70,
//                               child: PageView(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 controller: p2,
//                                 children: [
//                                   Obx(
//                                     () => IconButton(
//                                       onPressed: cam.clickingImage.value
//                                           ? null
//                                           : () {
//                                               cam.clickPhoto();
//                                             },
//                                       icon: Center(
//                                         child: Icon(
//                                           Icons.circle,
//                                           size: 60,
//                                           color: cam.clickingImage.value
//                                               ? AppColors.grey.withOpacity(0.4)
//                                               : AppColors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       cam.videoRecording();
//                                     },
//                                     icon: Obx(
//                                       () => !cam.isRecording.value
//                                           ? Icon(
//                                               Icons.circle,
//                                               size: 60,
//                                               color: Colors.red,
//                                             )
//                                           : Icon(
//                                               Icons.stop,
//                                               size: 60,
//                                               color: Colors.red,
//                                             ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Spacer(),
//                             Container(
//                               height: 70,
//                               width: 70,
//                               child: Obx(() =>
//                                   cam.lensDirection == CameraLensDirection.front
//                                       ? IconButton(
//                                           onPressed: () {
//                                             final a = cameras!.firstWhere(
//                                                 (element) =>
//                                                     element.lensDirection ==
//                                                     CameraLensDirection.back);

//                                             cam.initializeCamera(a);
//                                           },
//                                           icon: Icon(
//                                             Icons.camera_front_sharp,
//                                             color: AppColors.white,
//                                           ))
//                                       : IconButton(
//                                           onPressed: () {
//                                             final a = cameras!.firstWhere(
//                                                 (element) =>
//                                                     element.lensDirection ==
//                                                     CameraLensDirection.front);

//                                             cam.initializeCamera(a);
//                                           },
//                                           icon: Icon(
//                                             Icons.camera_rear_rounded,
//                                             color: AppColors.white,
//                                           ))),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             : Center(
//                 child: CircularProgressIndicator(),
//               )),
//       ),
//     );
//   }
// }
