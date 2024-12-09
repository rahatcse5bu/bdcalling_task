import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/custom_appbar.dart';
import '../../../constant/app_color.dart';
import '../controllers/login_controller.dart';

class VerificationView extends StatelessWidget {
  final LoginController controller = Get.find<LoginController>();

  final emailController = TextEditingController();
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
            appBar: CustomAppBar.appBar(title: "User Verification", centerTitle: true, backgroundColor: AppColors.primary,leadingIcon: Icons.arrow_back_ios),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: codeController,
              decoration: InputDecoration(labelText: 'Activation Code'),
            ),
            SizedBox(height: 20),
            Obx(() {
              return controller.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        final email = emailController.text;
                        final code = codeController.text;

                        if (email.isNotEmpty && code.isNotEmpty) {
                          controller.verifyUser(email, code);
                        } else {
                          Get.snackbar('Error', 'Please fill in all fields.');
                        }
                      },
                      child: Text('Verify Account'),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
