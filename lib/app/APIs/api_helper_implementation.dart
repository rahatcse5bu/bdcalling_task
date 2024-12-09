import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../common/models/contest_model.dart';
import '../common/models/question_model.dart';
import '../constant/app_config.dart';
import '../models/job-category-model.dart';

import '../modules/login/models/login_request_model.dart';
import '../modules/login/models/login_response_model.dart';
import '../modules/register/models/register_model.dart';


import '../modules/tasks/models/task_model.dart';
import '../storage/storage_helper.dart';
import 'api_helper.dart';
import 'custom_error.dart';

class ApiHelperImpl extends GetConnect implements ApiHelper {
  @override
  void onInit() {
    super.onInit();
    // httpClient.baseUrl = AppConfig.baseUrl + AppConfig.apiVersion + '/';
    httpClient.baseUrl = AppConfig.baseUrl ;
    httpClient.timeout = Duration(seconds: AppConfig.timeoutDuration);
    httpClient.defaultContentType = 'application/json';

    httpClient.addRequestModifier<Object?>((request) {
      log('Request: ${request.method} ${request.url}');
      log('Headers: ${request.headers}');
      log('Body: ${request.bodyBytes}');
      return request;
    });

    httpClient.addResponseModifier<Object?>((request, response) {
      log('Response: ${response.statusCode}, Body: ${response.body}');
      return response;
    });

        // Add Bearer Token to Headers
    httpClient.addAuthenticator<Object?>((request) async {
      final token = await StorageHelper.getToken(); // Get token from SharedPreferences
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });
  }

  Future<Either<CustomError, T>> _processResponse<T>(
    Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    if (response.statusCode == 200) {
      try {
        return Right(fromJson(response.body));
      } catch (e) {
        return Left(CustomError(500, message: 'Parsing error: $e'));
      }
    } else {
      return Left(CustomError(response.statusCode, message: response.statusText ?? 'Unknown error'));
    }
  }

  // Refactored API call helper
  Future<Either<CustomError, Response>> _makeRequest(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(CustomError(response.statusCode, message: response.statusText ?? 'Request failed'));
      }
    } catch (e) {
      return Left(CustomError(500, message: 'Network error: $e'));
    }
  }

  @override
  Future<Either<CustomError, Response>> register(dynamic  register) async {
    return _makeRequest(() => post('user/register', register));
  }

  @override
  Future<Either<CustomError, LoginResponseModel>> login(LoginRequestModel payload) async {
    try {
      // Call the login endpoint
      final response = await post('user/login', payload.toJson());
      
      // Handle response
      if (response.statusCode == 200 && response.body['status'] == "Success") {
        final loginResponse = LoginResponseModel.fromJson(response.body);
        return Right(loginResponse); // Return the successful response
      } else {
        return Left(
          CustomError(
            response.statusCode ?? 500,
            message: response.body['message'] ?? 'Login failed',
          ),
        );
      }
    } catch (e) {
      return Left(CustomError(500, message: 'An unexpected error occurred: $e'));
    }
  }
 @override
Future<Either<CustomError, List<TaskModel>>> getAllTasks() async {
  log("getting all tasks");
  try {
    final response = await get('task/get-all-task');
    if (response.statusCode == 200) {
      final List<dynamic> tasksJson = response.body['data']['myTasks'];
      final tasks = tasksJson.map((json) => TaskModel.fromJson(json)).toList();
      log("tasks: ${tasks.join('--')}");
      return Right(tasks);
    } else {
      return Left(CustomError(response.statusCode ?? 500, message: response.body['message'] ?? 'Failed to fetch tasks'));
    }
  } catch (e) {
    return Left(CustomError(500, message: 'An unexpected error occurred: $e'));
  }
}
@override
Future<Either<CustomError, Response>> deleteTask(String taskId) async {
  try {
    final response = await delete('task/delete-task/$taskId');
    if (response.statusCode == 200) {
      return Right(response);
    } else {
      return Left(CustomError(response.statusCode ?? 500, message: response.body['message'] ?? 'Task deletion failed'));
    }
  } catch (e) {
    return Left(CustomError(500, message: 'An unexpected error occurred: $e'));
  }
}
@override
Future<Either<CustomError, TaskModel>> getTask(String taskId) async {
  try {
    final response = await get('task/get-task/$taskId');
    if (response.statusCode == 200) {
      return Right(TaskModel.fromJson(response.body['data']));
    } else {
      return Left(CustomError(response.statusCode ?? 500, message: response.body['message'] ?? 'Failed to fetch task'));
    }
  } catch (e) {
    return Left(CustomError(500, message: 'An unexpected error occurred: $e'));
  }
}
@override
Future<Either<CustomError, TaskModel>> createTask(Map<String, dynamic> payload) async {
  try {
    final response = await post('task/create-task', payload);
    if (response.statusCode == 200) {
      return Right(TaskModel.fromJson(response.body['data']));
    } else {
      return Left(CustomError(response.statusCode ?? 500, message: response.body['message'] ?? 'Task creation failed'));
    }
  } catch (e) {
    return Left(CustomError(500, message: 'An unexpected error occurred: $e'));
  }
}
@override
Future<Either<CustomError, Response>> getProfile() async {
  try {
    final response = await get('user/my-profile');
    if (response.statusCode == 200) {
      return Right(response);
    } else {
      return Left(CustomError(response.statusCode ?? 500, message: response.body['message'] ?? 'Failed to fetch profile'));
    }
  } catch (e) {
    return Left(CustomError(500, message: 'An unexpected error occurred: $e'));
  }
}
@override
Future<Either<CustomError, Response>> updateProfile(FormData formData) async {
  try {
    final response = await patch('user/update-profile', formData);
    if (response.statusCode == 200) {
      return Right(response);
    } else {
      return Left(CustomError(response.statusCode ?? 500, message: response.body['message'] ?? 'Profile update failed'));
    }
  } catch (e) {
    return Left(CustomError(500, message: 'An unexpected error occurred: $e'));
  }
}
@override
Future<Either<CustomError, Response>> activateUser(Map<String, dynamic> payload) async {
  try {
    final response = await post('user/activate-user', payload);
    if (response.statusCode == 200) {
      return Right(response);
    } else {
      return Left(CustomError(response.statusCode ?? 500, message: response.body['message'] ?? 'Activation failed'));
    }
  } catch (e) {
    return Left(CustomError(500, message: 'An unexpected error occurred: $e'));
  }
}

  


}
