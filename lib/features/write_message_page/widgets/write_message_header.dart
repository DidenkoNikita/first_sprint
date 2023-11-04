import 'package:flutter/material.dart';

class WriteMessageHeader extends StatelessWidget implements PreferredSizeWidget {
  const WriteMessageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
      elevation: 0,
      title: const Text(
        'Write a message',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
