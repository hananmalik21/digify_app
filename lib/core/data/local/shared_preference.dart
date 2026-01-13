// import 'dart:convert';
// import 'package:digital_eye/src/core/common/common_models/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPreferencesService {
//   static const String userDataKey = "userData";
//
//   static final SharedPreferencesService _instance =
//       SharedPreferencesService._();
//
//   final pref = SharedPreferences.getInstance();
//
//   SharedPreferencesService._();
//
//   factory SharedPreferencesService() {
//     return _instance;
//   }
//
//   late SharedPreferences _prefs;
//
//   init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }
//
//
//   /* --------- save user data -------- */
//    saveUserData(UserData userData)  {
//     String userDataJson = jsonEncode(userData.toJson());
//      _prefs.setString(userDataKey, userDataJson);
//   }
//
//   /* --------- get user data -------- */
//
//   Future<UserData?> loadUserData() async {
//     String? userDataJson = _prefs.getString(userDataKey);
//     if (userDataJson != null) {
//       Map<String, dynamic> userDataMap = jsonDecode(userDataJson);
//       return UserData.fromJson(userDataMap);
//     }
//     return null;
//   }
//    Future<void> removeUserData() async {
//     await _prefs.remove(userDataKey);
//   }
// }
