// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Message extends StatefulWidget {
  const Message({super.key, required this.message, required this.id});

  final dynamic message;
  final int id;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    final bool isUser = widget.id == widget.message['user_id'];

    String _formatNumber(int num) {
      return num.toString().padLeft(2, '0');
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: isUser
                    ? const Color.fromRGBO(223, 197, 255, 1)
                    : const Color.fromRGBO(51, 51, 51, 1),
                borderRadius: isUser
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(10),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(20),
                      )),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    widget.message['text'],
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isUser ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    Text(
                      '${_formatNumber(DateTime.parse(widget.message['created_at']).hour)}:${_formatNumber(DateTime.parse(widget.message['created_at']).minute)}',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: isUser
                              ? Colors.black
                              : const Color.fromRGBO(170, 170, 170, 1)),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    isUser
                        ? SvgPicture.asset(
                            'assets/svg/double-checkmark.svg',
                            color: widget.message['is_read']
                                ? const Color.fromRGBO(187, 131, 255, 1)
                                : const Color.fromRGBO(170, 170, 170, 1),
                          )
                        : const SizedBox()
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
