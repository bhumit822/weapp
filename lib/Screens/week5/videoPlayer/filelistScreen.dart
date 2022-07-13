import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weapp/Screens/week5/videoPlayer/videoplayerControler.dart';
import 'package:weapp/Screens/week5/videoPlayer/vlcVideoscreen.dart';

class VideoListScreen extends StatelessWidget {
  VideoListScreen({Key? key}) : super(key: key);

  VideoDEmoController _cont = Get.put(VideoDEmoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_cont.folderName.value),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: _cont.files.length,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () async {
                    _cont.isFirstScreen.value = true;
                    final _file = await _cont.files[index].file;
                    _cont.fileIndex.value = index;
                    _cont.plaay(index);
                    // _cont.playVideo(_file!);
                  },

                  // onTap: () async {
                  //   final _file = await _cont.files[index].fileWithSubtype;
                  //   _cont.fileIndex.value = index;
                  //   _cont.currentfile.value = _file!;
                  //   print(_file.path);
                  //   Get.to(() => VlcVideoScreen());
                  //   _cont.vlcplay();
                  //   // _cont.playVideo(_file!);
                  // },
                  title: Text(_cont.files[index].title ?? "Untitled"),
                  subtitle: Text(Duration(seconds: _cont.files[index].duration)
                      .toString()
                      .split(".")
                      .first));
            }),
      ),
    );
  }
}
