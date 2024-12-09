import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLoginPressed;

  const LoginWidget({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.onLoginPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        SizedBox(height: 16),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        SizedBox(height: 32),
        ElevatedButton(
          onPressed: onLoginPressed,
          child: Text('Login'),
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
    );
  }
}
