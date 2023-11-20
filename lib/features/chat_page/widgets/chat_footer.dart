// ignore_for_file: use_build_context_synchronously

import 'package:evently_sprint/requests/create_message/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';

class ChatFooter extends StatefulWidget {
  const ChatFooter(
      {Key? key,
      required this.id,
      required this.chatId,
      required this.addMessage})
      : super(key: key);

  final int id;
  final int? chatId;
  final Function(Map<String, dynamic>) addMessage;

  @override
  State<ChatFooter> createState() => _ChatFooterState();
}

class _ChatFooterState extends State<ChatFooter> {
  bool isKeyboardVisible = false;
  String messageText = '';
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        isKeyboardVisible = visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isKeyboardVisible ? keyboardHeight + 60 : 74.0,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(48, 48, 48, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/svg/plus-circle.svg'),
                    ),
                  ),
                  Container(
                    width: 287,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(36, 36, 36, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      controller: _messageController,
                      onChanged: (text) {
                        setState(() {
                          messageText = text;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Type your message',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(150, 155, 171, 1),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(227, 245, 99, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        messageText = _messageController.text;
                        if (messageText != '') {
                          final message = await CreateMessage(
                            chatId: widget.chatId,
                            id: widget.id,
                            text: messageText,
                            postId: null,
                          ).createMessage();
                          widget.addMessage(message);
                          _messageController.clear();
                          FocusScope.of(context).unfocus();
                        }
                      },
                      icon: SvgPicture.asset('assets/svg/send.svg'),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
