import 'package:evently_sprint/router/router.dart';
// import 'package:evently_sprint/theme/theme.dart';
import 'package:flutter/material.dart';

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evently',
      theme: ThemeData.dark(),
      routes: routes,
    );
  }
}