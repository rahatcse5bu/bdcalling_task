import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../common/models/contest_model.dart';
import '../common/models/question_model.dart';
import '../models/job-category-model.dart';

import '../modules/login/models/login_request_model.dart';
import '../modules/login/models/login_response_model.dart';
import '../modules/register/models/register_model.dart';

import '../modules/tasks/models/task_model.dart';
import 'custom_error.dart';

abstract class ApiHelper {
  // Future<Either<CustomError, LoginResponse>> login(LoginRequestModel login);
Future<Either<CustomError, LoginResponseModel>> login(LoginRequestModel payload);

  Future<Either<CustomError, Response>> register(dynamic  register);
  Future<Either<CustomError, Response>> activateUser(Map<String, dynamic> payload);
  Future<Either<CustomError, Response>> updateProfile(FormData formData);
  Future<Either<CustomError, Response>> getProfile();
  Future<Either<CustomError, TaskModel>> createTask(Map<String, dynamic> payload);
  Future<Either<CustomError, TaskModel>> getTask(String taskId);
  Future<Either<CustomError, Response>> deleteTask(String taskId);
  Future<Either<CustomError, List<TaskModel>>> getAllTasks();
  // Future<Either<CustomError, UserProfile>> getUserProfile(String userId);


}
