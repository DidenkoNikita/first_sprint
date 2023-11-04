import 'package:flutter/material.dart';

class CommentsHeader extends StatelessWidget implements PreferredSizeWidget {
  const CommentsHeader({super.key, required this.comments});
  final List<Map<String, dynamic>> comments;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
      elevation: 0,
      title: Text(
        '${comments.length} comments',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
