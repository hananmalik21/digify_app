import 'package:digify_app/core/model/user_data_model.dart';
import 'package:digify_app/core/services/shared_preference.dart';
import 'package:digify_app/core/utils/static_info.dart';
import 'package:flutter_riverpod/legacy.dart' show StateNotifier;


class UserDataNotifier extends StateNotifier<AuthState> {
  UserDataNotifier() : super(const AuthState.initial()) {
    _restoreFromPrefs();
  }

  final SharedPreferencesService _prefs = SharedPreferencesService();

  Future<void> _restoreFromPrefs() async {
    final saved = await _prefs.loadUserData(); // returns AuthModel
    if (saved != null) {
      StaticInfo.authToken = saved.accessToken;
      state = AuthState(isLoading: false, user: saved);
    } else {
      state = const AuthState(isLoading: false, user: null);
    }
  }

  Future<void> setUserData(AuthModel auth) async {
    StaticInfo.authToken = auth.accessToken;
    state = AuthState(isLoading: false, user: auth);
    await _prefs.saveUserData(auth);
  }

  Future<void> clearUserData() async {
    StaticInfo.authToken = null;
    state = const AuthState(isLoading: false, user: null);
    await _prefs.removeUserData();
  }
}








// import 'dart:developer';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/legacy.dart' show StateNotifier;
// import 'package:moot_web/core/model/user_data_model.dart';
// import 'package:moot_web/core/services/shared_preference.dart';
// import 'package:moot_web/core/utils/static_info.dart';
//
//
// class UserDataNotifier extends StateNotifier<AuthModel?> {
//   UserDataNotifier() : super(null);
//
//   void setUserData(AuthModel userData) {
//     state = null;
//     state = userData;
//     StaticInfo.authToken = state?.accessToken;
//     if(kDebugMode){
//       log("ACCESS TOKEN IS ${StaticInfo.authToken}");
//     }
//     SharedPreferencesService().saveUserData(state!);
//   }
//
//   Future<void> clearUserData() async {
//     state = null;
//     StaticInfo.authToken = null;
//     SharedPreferencesService().removeUserData();
//   }
//
//   Future getDataFromLocal({
//     required Function() onSuccess,
//     required Function() onFailure,
//   }) async {
//     state = await SharedPreferencesService().loadUserData();
//     StaticInfo.authToken = state?.accessToken;
//     if (state != null) {
//       onSuccess();
//     } else {
//       onFailure();
//     }
//   }
// }
//
//
