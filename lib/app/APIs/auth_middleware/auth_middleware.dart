import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../storage/storage_helper.dart';

class AuthMiddleware extends GetMiddleware {
  static String? token; // Static variable to store the token

  // Fetch the token during app initialization
  static Future<void> initialize() async {
    token = await StorageHelper.getToken();
  }

  @override
  RouteSettings? redirect(String? route) {
    // Check if the token exists
    if (token == null) {
      return const RouteSettings(name: '/login'); // Redirect to login page
    }
    return null; // Allow navigation
  }
}
