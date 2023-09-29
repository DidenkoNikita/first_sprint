import 'package:evently_sprint/router/home_router.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evently',
      theme: ThemeData.dark(),
      routes: routes,
    );
  }
}