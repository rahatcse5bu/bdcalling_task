import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/custom_appbar.dart';
import '../../../constant/app_color.dart';
import '../controllers/register_controller.dart';
import '../widgets/register_form.dart';


class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
             appBar: CustomAppBar.appBar(title: "Register", centerTitle: true, backgroundColor: AppColors.primary,leadingIcon: Icons.arrow_back_ios),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RegisterForm(),
              Center(
                      child: GestureDetector(
                        onTap: (){
                          Get.toNamed('login');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text("Login"))),
                    )
          ],
        ), // Add the RegisterForm widget here
      ),
    );
  }
}
