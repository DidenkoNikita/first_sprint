import 'package:evently_sprint/features/login_page/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
        elevation: 0,
        title: const Text(
          'Log in',
        ),
      ),
      body: const LoginFormWidget(),
    );
  }
}
