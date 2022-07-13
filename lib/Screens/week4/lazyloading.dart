import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weapp/constdata/iconstring.dart';
import 'package:weapp/constdata/textstyles.dart';

class LazyLoading extends StatefulWidget {
  const LazyLoading({Key? key}) : super(key: key);

  @override
  State<LazyLoading> createState() => _LazyLoadingState();
}

class _LazyLoadingState extends State<LazyLoading> {
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(lisneer);

    getlocal();
  }

  getlocal() async {
    await Future.delayed(Duration(seconds: 2));

    _data = await getData();
    if (mounted) {
      setState(() {});
    }
  }

  List<GoogleImage>? _data;
  Dio _dio = Dio();
  Future<List<GoogleImage>> getData([int page = 0]) async {
    final respons = await _dio.get(
      "https://serpapi.com/search.json?q=Cars&tbm=isch&ijn=${page}&api_key=144327533f54888b08aef22928cc2504a36ba5857e007826858acff71a8c1364",
    );
    final data = respons.data["images_results"] as List;
    return data
        .map((e) => GoogleImage.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  bool isEnd = false;
  int stp = 0;
  lisneer() {
    if (_controller.position.extentAfter < 10) {
      stp++;
      Future.delayed(Duration(seconds: 1), () async {
        try {
          final _new = await getData(stp);
          _data!.addAll(_new);
          setState(() {});
        } catch (e) {
          if (mounted) {
            setState(() {
              isEnd = true;
            });
          }
        }
      });
    }
  }

  int length = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: AppColors.bluewhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.skyblue,
          title: Text("LazyLoading"),
        ),
        body: _data == null
            ? Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(AppImages.loader),
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
                itemCount: _data!.length + 1,
                controller: _controller,
                itemBuilder: (context, index) {
                  return index < _data!.length
                      ? Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Image.network(
                            _data![index].url,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, event) {
                              if (event == null) {
                                return child;
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        )
                      : isEnd
                          ? Container()
                          : Image.asset(AppImages.loader);
                }));
  }
}

class GoogleImage {
  final String url;
  GoogleImage({required this.url});
  factory GoogleImage.fromJson(Map<String, dynamic> json) {
    return GoogleImage(
      url: json["original"],
    );
  }
}
