import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/task_controller.dart';


class TaskCreateView extends StatelessWidget {
  final TaskController controller = Get.find<TaskController>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            Obx(() {
              return controller.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        final title = titleController.text.trim();
                        final description = descriptionController.text.trim();
                        if (title.isNotEmpty && description.isNotEmpty) {
                          controller.createTask(title, description);
                          Get.back(); // Navigate back to the task list
                        } else {
                          Get.snackbar('Error', 'All fields are required');
                        }
                      },
                      child: Text('Create Task'),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
