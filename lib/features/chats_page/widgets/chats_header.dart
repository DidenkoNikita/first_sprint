import 'package:evently_sprint/features/write_message_page/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatsHeader extends StatelessWidget implements PreferredSizeWidget {
  const ChatsHeader({super.key, required this.chatsList});
  final List<dynamic> chatsList;

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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WriteMessagePage(
                        chatsList: chatsList,
                      )));
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
