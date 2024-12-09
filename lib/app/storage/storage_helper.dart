import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const String _tokenKey = "auth_token";
  static const String _userInfoKey = "user_info";
    static const String _userVerifiedKey = "user_verified";

  // Set token
  static Future<void> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Get token
  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Remove token (optional, for logout)
  static Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Check if token exists
  static Future<bool> hasToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_tokenKey);
  }



   // Set user information
  static Future<void> setUserInfo(Map<String, dynamic> userInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userInfoKey, jsonEncode(userInfo)); // Store as JSON string
  }

  // Get user information
  static Future<Map<String, dynamic>?> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userInfoJson = prefs.getString(_userInfoKey);
    if (userInfoJson != null) {
      return jsonDecode(userInfoJson); // Decode JSON string to Map
    }
    return null;
  }

  // Remove user information
  static Future<void> removeUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userInfoKey);
  }


  // Set verification status
  static Future<void> setUserVerified(bool isVerified) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userVerifiedKey, isVerified);
  }

  // Get verification status
  static Future<bool> isUserVerified() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userVerifiedKey) ?? false;
  }
}
