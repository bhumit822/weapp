import 'dart:developer';

import 'package:get/get.dart';
import 'package:weapp/Screens/week3/Sqflight/databsehelper.dart';

class SqfLiteController extends GetxController {
  final RxList<NotesModel> data = (List<NotesModel>.of([])).obs;

  fetchdata() async {
    final List<NotesModel> _data = await DBHelper.instance.queryAll();

    data.assignAll(_data);
    data.refresh();
    print(_data);
    return data;
  }

  addData(String title, String description, [String? image]) async {
    final _data = {
      DBHelper.columnTitle: title,
      DBHelper.columnDescription: description,
      DBHelper.columnImage: image
    };
    int a = await DBHelper.instance.insert(_data);
    log(a.toString());

    fetchdata();
  }

  Stream<RxList> ststst() async* {
    final List<NotesModel> _data = await DBHelper.instance.queryAll();

    data.assignAll(_data);
    print(_data);
    yield data;
  }

  updaterow(int id, String title, String description, [String? image]) async {
    final _data = {
      DBHelper.columnId: id,
      DBHelper.columnTitle: title,
      DBHelper.columnDescription: description,
      DBHelper.columnImage: image
    };

    await DBHelper.instance.update(_data);
    fetchdata();
  }

  deleteRow(int id) async {
    await DBHelper.instance.delete(id);
    fetchdata();
  }
}
