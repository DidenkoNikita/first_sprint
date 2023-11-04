import 'package:flutter/material.dart';

class ChangePhotoHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const ChangePhotoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'My photo',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
