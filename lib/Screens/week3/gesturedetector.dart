import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GestureDetectordemo extends StatefulWidget {
  const GestureDetectordemo({Key? key}) : super(key: key);

  @override
  State<GestureDetectordemo> createState() => _GestureDetectordemoState();
}

class _GestureDetectordemoState extends State<GestureDetectordemo> {
  @override
  void dispose() {
    super.dispose();
    // pp.dispose();
  }

  List a = [
    "https://wallpaperaccess.com/full/846773.jpg",
    "https://webneel.com/wallpaper/sites/default/files/images/01-2014/1-flower-wallpaper.jpg",
    "https://wallpaperaccess.com/full/132722.jpg",
    "https://wallpaperaccess.com/full/132721.jpg",
    "https://wallpapercave.com/wp/wp6495234.jpg",
  ];

  static bool isv = false;
  PageController pp = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        dragStartBehavior: DragStartBehavior.start,
        onHorizontalDragUpdate: (details) {
          setState(() {
            isv = false;
          });
        },
        onVerticalDragUpdate: (details) {
          setState(() {
            isv = true;
          });
        },

        // child: PageView.builder(
        //     reverse: true,
        //     scrollDirection: !isv ? Axis.horizontal : Axis.vertical,
        //     itemBuilder: (context, index) {
        //       return PhotoView(
        //           imageProvider: NetworkImage(a[index % a.length]));
        //     }),
        // child: CarouselSlider(
        //   options: CarouselOptions(
        //     height: MediaQuery.of(context).size.height,
        //     viewportFraction: 1.0,
        //     scrollDirection: !isv ? Axis.horizontal : Axis.vertical,
        //     enlargeCenterPage: false,
        //     // autoPlay: false,
        //   ),
        //   items: a
        //       .map((item) => Container(
        //           height: MediaQuery.of(context).size.height,
        //           child: PhotoView(
        //               enableRotation: true,
        //               imageProvider: NetworkImage(item))))
        //       .toList(),
        // )
        child: CarouselSlider.builder(
            itemCount: a.length,
            itemBuilder: (context, index, ind) {
              print(index);
              return Container(
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  child: PhotoViewGallery(
                gaplessPlayback: true,
                enableRotation: true,
                pageOptions: [
                  PhotoViewGalleryPageOptions(
                      minScale: 0.10, imageProvider: NetworkImage(a[index]))
                ],
              ));
            },
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              scrollDirection: !isv ? Axis.horizontal : Axis.vertical,
              enlargeCenterPage: false,
              // autoPlay: false,
            )),

        // child: PhotoViewGallery.builder(
        //     scrollPhysics: BouncingScrollPhysics(),
        //     enableRotation: true,
        //     // pageController: pp,
        //     onPageChanged: (v) {},
        //     itemCount: a.length,
        //     scrollDirection: !isv ? Axis.horizontal : Axis.vertical,
        //     builder: (contex, index) {
        //       return PhotoViewGalleryPageOptions(
        //           basePosition: Alignment.center,
        //           maxScale: PhotoViewComputedScale.contained * 4,
        //           minScale: PhotoViewComputedScale.contained,
        //           imageProvider: NetworkImage(a[index]));
        //     }),
      ),
    );
  }
}
