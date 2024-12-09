import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'dart:io';
import '../../../APIs/api_helper.dart';
import '../../../APIs/api_helper_implementation.dart';
import '../models/register_model.dart';

class RegisterController extends GetxController {
  final ApiHelper _apiHelper = Get.find<ApiHelper>();
  var isLoading = false.obs;

Future<void> registerUser(RegisterRequestModel model) async {
  isLoading.value = true;
  try {
    // if (model.filePath == null || !File(model.filePath!).existsSync()) {
    //   Get.snackbar('Error', 'Please select a valid file.');
    //   isLoading.value = false;
    //   return;
    // }

    final response = await _apiHelper.register(model.toFormData());
    response.fold(
      (error) => Get.snackbar('Error', error.message),
      (data) => Get.snackbar('Success', 'Registration successful!'),
    );
  } catch (e) {
    Get.snackbar('Error', 'Unexpected error: $e');
    log('Unexpected error: $e');
  } finally {
    isLoading.value = false;
  }
}

 Future<String?> pickFile() async {
  try {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      final fullPath = result.files.single.path!;
      log('Picked File Path: $fullPath'); // Log the full path for debugging
      return fullPath;
    } else {
      log('No file selected.');
    }
  } catch (e) {
    log('FilePicker Error: $e');
  }
  return null; // Return null if no file is selected
}

}
