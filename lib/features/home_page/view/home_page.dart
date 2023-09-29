import 'package:evently_sprint/features/home_page/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stories(),
            SizedBox(
              height: 20,
            ),
            CalendarOfEventsHome(),
            SizedBox(
              height: 20,
            ),
            Post()
          ],
        ),
      ),
      bottomNavigationBar: HomeFooter(),
    );
  }
}
