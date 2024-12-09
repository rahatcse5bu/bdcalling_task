import 'package:bdcalling_task/app/common/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/app_color.dart';
import '../../../routes/app_pages.dart';
import '../controller/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    controller.fetchProfile(); // Fetch profile on load

    return Scaffold(
              appBar: CustomAppBar.appBar(onLeadingPressed: (){
              Get.toNamed(Routes.dashboard);
            }, title: "Profile", centerTitle: true, backgroundColor: AppColors.primary,leadingIcon: Icons.arrow_back_ios),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }
        if (controller.profile.value == null) {
          return Center(child: Text('No profile data available'));
        }

        final profile = controller.profile.value!;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: profile.image != null
                    ? NetworkImage(profile.image!)
                    : AssetImage('assets/images/user_avatar.png') as ImageProvider,
              ),
              SizedBox(height: 16),
              Text('Name: ${profile.firstName} ${profile.lastName}', style: TextStyle(fontSize: 18)),
              Text('Email: ${profile.email}', style: TextStyle(fontSize: 16)),
              Text('Address: ${profile.address}', style: TextStyle(fontSize: 16)),
            ],
          ),
        );
      }),
    );
  }
}
