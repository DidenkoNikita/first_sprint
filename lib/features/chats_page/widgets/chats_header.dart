import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatsHeader extends StatelessWidget implements PreferredSizeWidget {
  const ChatsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
      elevation: 0,
      title: Row(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'Chats',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/write_message');
            },
            icon: SvgPicture.asset('assets/svg/edit-rectangle.svg'),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
