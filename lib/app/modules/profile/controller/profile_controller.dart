import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import '../../../APIs/api_helper.dart';

import '../models/profile_model.dart';

class ProfileController extends GetxController {
  final ApiHelper _apiHelper = Get.find<ApiHelper>();

  var profile = Rxn<ProfileModel>(); // Holds user profile
  var isLoading = false.obs; // Loading indicator
  var error = ''.obs; // Error message

Future<void> fetchProfile() async {
  isLoading.value = true;
  error.value = '';
  try {
    final result = await _apiHelper.getProfile();
    result.fold(
      (customError) => error.value = customError.message,
      (response) {
        profile.value = ProfileModel.fromJson(response.body['data']);
      },
    );
  } catch (e) {
    error.value = 'An unexpected error occurred.';
  } finally {
    isLoading.value = false;
  }
}


  // Update user profile
  Future<void> updateProfile(FormData formData) async {
    isLoading.value = true;
    error.value = '';
    try {
      final result = await _apiHelper.updateProfile(formData);
      result.fold(
        (customError) => error.value = customError.message,
        (response) {
          profile.value = ProfileModel.fromJson(response.body['data']);
          Get.snackbar('Success', 'Profile updated successfully');
        },
      );
    } catch (e) {
      error.value = 'An unexpected error occurred.';
    } finally {
      isLoading.value = false;
    }
  }

  // Activate user account
  Future<void> activateUser(Map<String, dynamic> payload) async {
    isLoading.value = true;
    error.value = '';
    try {
      final result = await _apiHelper.activateUser(payload);
      result.fold(
        (customError) => error.value = customError.message,
        (response) {
          Get.snackbar('Success', 'Account activated successfully');
        },
      );
    } catch (e) {
      error.value = 'An unexpected error occurred.';
    } finally {
      isLoading.value = false;
    }
  }
}
