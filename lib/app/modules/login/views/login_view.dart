import 'package:bdcalling_task/app/common/custom_appbar.dart';
import 'package:bdcalling_task/app/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../widgets/login_widget.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(title: "Login", centerTitle: true, backgroundColor: AppColors.primary,leadingIcon: Icons.arrow_back_ios),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: LoginWidget(
                        emailController: controller.emailController,
                        passwordController: controller.passwordController,
                        onLoginPressed: () {
                          final email = controller.emailController.text.trim();
                          final password = controller.passwordController.text.trim();
                          if (email.isNotEmpty && password.isNotEmpty) {
                            controller.loginUser(email, password);
                          } else {
                            Get.snackbar('Error', 'Please fill in all fields');
                          }
                        },
                      ),
                    ),
            
                  ],
                ),
        ),
      ),
    );
  }
}
