class UserModal {
  final int userId;
  final String name;
  final String email;
  final String profilPicture;
  final String createdat;

  UserModal(
      {required this.userId,
      required this.name,
      required this.email,
      required this.profilPicture,
      required this.createdat});

  factory UserModal.fromJson(Map<String, dynamic> json) {
    return UserModal(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        profilPicture: json["profile_pic"],
        createdat: json["created_at"]);
  }
}

class ApiUrl {
  static String baseUrl = "http://192.168.1.39/Practical_Api/api/";
  static String tocken =
      "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc";
  static String addUser = "add_user";
  static String getUserList = "get_user_list";
  static String getUserDetail = "get_user_details";
  static String deleteUser = "delete_user";
  static String changeProfileImage = "change_profile_pic";
  static String editUserDetail = "edit_user_details";
}
