import 'package:evently_sprint/requests/create_comment/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';

class CommentsFooter extends StatefulWidget {
  const CommentsFooter({
    Key? key,
    required this.comments,
    required this.postId,
    required this.onAddComment,
  }) : super(key: key);

  final int postId;
  final List<Map<String, dynamic>> comments;
  final Function(Map<String, dynamic>) onAddComment;

  @override
  State<CommentsFooter> createState() => _CommentsFooterState();
}

class _CommentsFooterState extends State<CommentsFooter> {
  bool isKeyboardVisible = false;
  String commentText = '';
  final TextEditingController _commentController = TextEditingController();

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
                      controller: _commentController,
                      onChanged: (text) {
                        setState(() {
                          commentText = text;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Comment',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
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
                        commentText = _commentController.text;
                        if (commentText != '') {
                          final comment = await CreateComment(
                            text: commentText,
                            postId: widget.postId,
                          ).createComment();
                          widget.onAddComment(comment);
                          _commentController.clear();
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
