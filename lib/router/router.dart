import 'package:evently_sprint/features/login_page/view/view.dart';
import 'package:evently_sprint/features/registration_page/view/view.dart';
import 'package:evently_sprint/features/start_page/view/view.dart';

final routes = {
  '/': (context) => const StartPage(),
  '/login': (context) => const LoginPage(),
  '/registration': (context) => const RegistrationPage()
};
