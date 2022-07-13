import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weapp/Screens/week3/Api/model/usermodel.dart';

class DioApi {
  Dio _dio = Dio();

  Future<List<UserModal>> getUserList() async {
    List<UserModal> fData = [];
    try {
      final _get = await _dio.get(ApiUrl.baseUrl + ApiUrl.getUserList,
          options: Options(headers: {"Token": ApiUrl.tocken}));

      if (_get.statusCode == 200) {
        List data = _get.data["data"];
        data.forEach((e) {
          fData.add(UserModal.fromJson(e));
        });

        return fData;
      } else {
        return fData;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went Wrong !!!");
      return fData;
    }
  }

  Future<bool> deleteUser(Map<String, dynamic> data) async {
    final _delete = await _dio.delete(ApiUrl.baseUrl + ApiUrl.deleteUser,
        queryParameters: data,
        options: Options(
          headers: {"Token": ApiUrl.tocken},
        ));

    if (_delete.statusCode == 200) {
      Fluttertoast.showToast(msg: "Successfully deleted.");
      return true;
    } else {
      Fluttertoast.showToast(msg: "Something went Wrong...");
      return false;
    }
  }

  Future<UserModal?> addnewUser(Map<String, dynamic> data, File file) async {
    try {
      FormData formdata = FormData.fromMap(
          {"profile_pic": await MultipartFile.fromFile(file.path)});
      final post = await _dio.post(ApiUrl.baseUrl + ApiUrl.addUser,
          queryParameters: data,
          data: formdata,
          options: Options(headers: {"Token": ApiUrl.tocken}));

      if (post.statusCode == 200) {
        UserModal _newUser = UserModal.fromJson(post.data["data"]);
        print(_newUser.createdat);
        Fluttertoast.showToast(msg: "Added new User.");
        return _newUser;
      }

      print("User Succssesfull added========================================");
    } catch (e) {
      print("ADD USER Error====================================$e");
      Fluttertoast.showToast(msg: "$e");
    }
  }

  updateUserdetail(Map<String, dynamic> data) async {
    try {
      final _put = await _dio.put(ApiUrl.baseUrl + ApiUrl.editUserDetail,
          queryParameters: data,
          options: Options(headers: {"Token": ApiUrl.tocken}));
      Fluttertoast.showToast(msg: "Updated User.");
      print(_put.data);
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went Wrong...");
      print("Update User error =========================$e");
    }
  }

  changeProfilepicture(Map<String, dynamic> data, File file) async {
    try {
      FormData formdata = FormData.fromMap(
          {"profile_pic": await MultipartFile.fromFile(file.path)});
      final post = await _dio.post(ApiUrl.baseUrl + ApiUrl.changeProfileImage,
          queryParameters: data,
          data: formdata,
          options: Options(headers: {"Token": ApiUrl.tocken}));
      Fluttertoast.showToast(msg: "Updated profile picture");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error Updated profile picture");
      print("Update profilepicture error =========================$e");
    }
  }
}
