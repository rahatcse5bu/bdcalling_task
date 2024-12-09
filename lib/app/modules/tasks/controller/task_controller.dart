import 'package:get/get.dart';
import '../../../APIs/api_helper.dart';
import '../models/task_model.dart';


class TaskController extends GetxController {
  final ApiHelper _apiHelper = Get.find<ApiHelper>();

  var tasks = <TaskModel>[].obs; // List of tasks
  var isLoading = false.obs; // Loading indicator
  var error = ''.obs; // Error message
 @override
  void onInit() {
    super.onInit();
    fetchAllTasks(); // Fetch tasks when the controller is initialized
  }
  // Fetch all tasks
  Future<void> fetchAllTasks() async {
    isLoading.value = true;
    error.value = '';
    try {
      final result = await _apiHelper.getAllTasks();
      result.fold(
        (customError) => error.value = customError.message,
        (taskList) => tasks.value = taskList,
      );
    } catch (e) {
      error.value = 'An unexpected error occurred.';
    } finally {
      isLoading.value = false;
    }
  }

  // Create a new task
  Future<void> createTask(String title, String description) async {
    isLoading.value = true;
    error.value = '';
    try {
      final payload = {'title': title, 'description': description};
      final result = await _apiHelper.createTask(payload);
      result.fold(
        (customError) => error.value = customError.message,
        (newTask) {
          tasks.add(newTask); // Add the new task to the list
          Get.snackbar('Success', 'Task created successfully');
        },
      );
    } catch (e) {
      error.value = 'An unexpected error occurred.';
    } finally {
      isLoading.value = false;
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    isLoading.value = true;
    error.value = '';
    try {
      final result = await _apiHelper.deleteTask(taskId);
      result.fold(
        (customError) => error.value = customError.message,
        (response) {
          tasks.removeWhere((task) => task.id == taskId);
          Get.snackbar('Success', 'Task deleted successfully');
        },
      );
    } catch (e) {
      error.value = 'An unexpected error occurred.';
    } finally {
      isLoading.value = false;
    }
  }
}
