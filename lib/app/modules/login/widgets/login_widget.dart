import 'package:flutter/material.dart';

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
      ],
    );
  }
}
