import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/custom_appbar.dart';
import '../../../constant/app_color.dart';
import '../../../routes/app_pages.dart';
import '../controller/profile_controller.dart';

class ProfileEditView extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Ensure the profile is fetched before populating
    controller.fetchProfile();

    return Scaffold(
            appBar: CustomAppBar.appBar(onLeadingPressed: (){
              Get.toNamed(Routes.dashboard);
            }, title: "Edit Profile", centerTitle: true, backgroundColor: AppColors.primary,leadingIcon: Icons.arrow_back_ios),


      body: Obx(() {
        // Show loading spinner while the profile is being fetched
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Show error message if there's an error fetching the profile
        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }

        final profile = controller.profile.value;

        // Populate text fields with existing profile data
        if (profile != null) {
          firstNameController.text = profile.firstName;
          lastNameController.text = profile.lastName;
          addressController.text = profile.address;
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 20),
              Obx(() {
                return controller.isLoading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          final formData = FormData({
                            'firstName': firstNameController.text.trim(),
                            'lastName': lastNameController.text.trim(),
                            'address': addressController.text.trim(),
                          });
                          controller.updateProfile(formData);
                        },
                        child: Text('Update Profile'),
                      );
              }),
            ],
          ),
        );
      }),
    );
  }
}
