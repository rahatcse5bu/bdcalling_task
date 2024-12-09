import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../widgets/login_widget.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LoginWidget(
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
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          Get.toNamed('register');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text("Register"))),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
