import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/custom_appbar.dart';
import '../../../constant/app_color.dart';
import '../../../routes/app_pages.dart';
import '../controller/task_controller.dart';
import '../widgets/task_item_widgets.dart';
import 'task_create_view.dart';

class TaskListView extends StatelessWidget {
  final TaskController controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: CustomAppBar.appBar(onLeadingPressed: (){
              Get.toNamed(Routes.dashboard);
            }, title: "Task List", centerTitle: true, backgroundColor: AppColors.primary,leadingIcon: Icons.arrow_back_ios),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }
        if (controller.tasks.isEmpty) {
          return Center(child: Text('No tasks available'));
        }
        return ListView.builder(
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            return TaskItemWidget(
              task: controller.tasks[index],
              onDelete: () => controller.deleteTask(controller.tasks[index].id),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => TaskCreateView()),
        child: Icon(Icons.add),
      ),
    );
  }
}
