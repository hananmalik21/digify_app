// core/services/shared_preference.dart
import 'dart:convert';
import 'package:digify_app/core/model/user_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String userDataKey = "userData";

  SharedPreferencesService._();
  static final SharedPreferencesService _instance =
  SharedPreferencesService._();
  factory SharedPreferencesService() => _instance;

  Future<void> saveUserData(AuthModel auth) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(auth.toJson());
    await prefs.setString(userDataKey, jsonString);

    if (kDebugMode) {
      debugPrint("✅ saveUserData -> $jsonString");
    }
  }

  Future<AuthModel?> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(userDataKey);

    if (kDebugMode) {
      debugPrint("ℹ️ loadUserData -> $jsonString");
    }

    if (jsonString == null) return null;

    final map = jsonDecode(jsonString) as Map<String, dynamic>;
    return AuthModel.fromJson(map);
  }

  Future<void> removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userDataKey);

    if (kDebugMode) {
      debugPrint("🧹 removeUserData");
    }
  }
}
