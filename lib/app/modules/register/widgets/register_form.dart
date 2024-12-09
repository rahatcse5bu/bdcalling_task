import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import '../models/register_model.dart';

class RegisterForm extends StatelessWidget {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final fileName = ''.obs;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>(); // Move _formKey to build
    final controller = Get.find<RegisterController>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: fnameController,
            decoration: InputDecoration(labelText: 'First Name'),
            validator: (value) => value == null || value.isEmpty
                ? 'First name is required'
                : null,
          ),
          TextFormField(
            controller: lnameController,
            decoration: InputDecoration(labelText: 'Last Name'),
            validator: (value) => value == null || value.isEmpty
                ? 'Last name is required'
                : null,
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) =>
                value == null || !value.contains('@') ? 'Invalid email' : null,
          ),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(labelText: 'Address'),
            validator: (value) => value == null || value.isEmpty
                ? 'Address is required'
                : null,
          ),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(labelText: 'Phone'),
            validator: (value) =>
                value != null && value.isNotEmpty && value.length != 10
                    ? 'Invalid phone number'
                    : null,
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) => value == null || value.length < 6
                ? 'Password must be at least 6 characters'
                : null,
          ),
          SizedBox(height: 20),
    
         Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final path = await controller.pickFile();
                    if (path != null) {
                      fileName.value = path.split('/').last;
                    }
                  },
                  child: Text('Upload Profile Picture'),
                ),
           
              ],
            ),
      
          SizedBox(height: 20),
          Obx(() {
            return controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final model = RegisterRequestModel(
                          firstName: fnameController.text,
                          lastName: lnameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          address: addressController.text,
                          phone: phoneController.text,
                          filePath: fileName.value.isNotEmpty ? fileName.value : null,
                        );
                        controller.registerUser(model);
                      }
                    },
                    child: Text('Register'),
                  );
          }),
        ],
      ),
    );
  }
}
