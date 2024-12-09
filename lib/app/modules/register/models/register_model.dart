import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';

class RegisterRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String address;
  final String? phone; // Optional if not mandatory
  final String? filePath; // Path to the file for upload

  RegisterRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.address,
    this.phone,
    this.filePath,
  });

  /// Converts the object to a JSON map
  Map<String, dynamic> toJson() {
    final data = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "address": address,
    };
    if (phone != null) data["phone"] = phone!;
    return data;
  }

 FormData toFormData() {
  final formData = FormData({
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "address": address,
    "phone": phone,
  });

  if (filePath != null) {
    log('Full File Path: $filePath');
    if (File(filePath!).existsSync()) {
      formData.files.add(MapEntry(
        "file",
        MultipartFile(File(filePath!).readAsBytesSync(), filename: filePath!.split('/').last),
      ));
    } else {
      log('File does not exist at path: $filePath');
    }
  }

  return formData;
}
}
