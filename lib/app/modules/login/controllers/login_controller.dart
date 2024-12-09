import 'package:bdcalling_task/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../APIs/api_helper.dart';

import '../../../storage/storage_helper.dart';
import '../models/login_request_model.dart';

class LoginController extends GetxController {
  final ApiHelper _apiHelper = Get.find<ApiHelper>();

  // TextEditingControllers for email and password input
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> loginUser(String email, String password) async {
    isLoading.value = true;
    try {
      final payload = LoginRequestModel(email: email, password: password);
      final response = await _apiHelper.login(payload);

      response.fold(
        (error) {
          Get.snackbar('Error', error.message);
        },
        (data) async {
          // Save the token to SharedPreferences
          await StorageHelper.setToken(data.token);
          // Fetch and save user profile
          final profileResponse = await _apiHelper.getProfile();
          profileResponse.fold(
            (error) {
              Get.snackbar('Error', 'Failed to fetch user profile.');
            },
            (profileData) async {
              await StorageHelper.setUserInfo(profileData.body['data']);
            },
          );
          // Navigate to the dashboard
          Get.snackbar('Success', 'Login Successful');
          Get.toNamed(Routes.dashboard); // Navigate to the dashboard
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred.');
    } finally {
      isLoading.value = false;
    }
  }

  // Check if user is already logged in
  Future<bool> isLoggedIn() async {
    return await StorageHelper.hasToken();
  }

  // Logout user
  Future<void> logout() async {
    await StorageHelper.removeToken(); // Clear the token
    await StorageHelper.removeUserInfo(); // Clear the token

    Get.offAllNamed('/login'); // Navigate to login screen
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Verify user (via email and activation code)
  Future<void> verifyUser(String email, String code) async {
    isLoading.value = true;
    try {
      final payload = {
        'email': email,
        'code': code,
      };

      final response = await _apiHelper.activateUser(payload);

      response.fold(
        (error) {
          Get.snackbar(
              'Error', error.message); // Show error if verification fails
        },
        (data) {
          // Save verification status
          StorageHelper.setUserVerified(true);

          Get.snackbar('Success',
              'Account activated successfully!'); // Show success if verification is successful
          // Optionally, navigate to a different screen or update the UI accordingly
          Get.toNamed(Routes.dashboard);
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred.');
    } finally {
      isLoading.value = false;
    }
  }
}
