import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import '../controller/profile_controller.dart';


class ProfileEditView extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profile = controller.profile.value;

    if (profile != null) {
      firstNameController.text = profile.firstName;
      lastNameController.text = profile.lastName;
      addressController.text = profile.address;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
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
      ),
    );
  }
}
