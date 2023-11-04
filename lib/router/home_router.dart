import 'package:evently_sprint/features/chats_page/view/view.dart';
import 'package:evently_sprint/features/home_page/view/view.dart';
import 'package:evently_sprint/features/profile_page/view/view.dart';
import 'package:evently_sprint/features/profile_settings_page/view/view.dart';
import 'package:evently_sprint/features/write_message_page/view/view.dart';

final routes = {
  '/': (context) => const HomePage(),
  '/profile': (context) => const ProfilePage(),
  '/profile_settings': (context) => const ProfileSettingsPage(),
  '/chats': (context) => const ChatsPage(),
  '/write_message': (context) => const WriteMessagePage(),
};
