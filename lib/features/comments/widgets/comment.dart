import 'package:evently_sprint/features/comments/widgets/widgets.dart';
import 'package:evently_sprint/requests/like_comment/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Comment extends StatefulWidget {
  const Comment({super.key, required this.comment, required this.userId});
  final Map<String, dynamic> comment;
  final int userId;

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 365,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(30, 30, 30, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromRGBO(223, 197, 255, 1),
                  ),
                  child: Center(
                    child: widget.comment['link_avatar'] != null
                        ? Image.network(
                            widget.comment['link_avatar'],
                            fit: BoxFit.cover,
                          )
                        : Text(
                            widget.comment['name'].substring(0, 1),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.comment['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      formatTime(widget.comment['created_at']),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.comment['text'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Spacer(),
                Text(
                  widget.comment['like'].length.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final comment =
                        await LikeComment(commentId: widget.comment['id'])
                            .likeComment();
                    setState(() {
                      widget.comment['like'] = comment['like'];
                    });
                  },
                  icon: SvgPicture.asset(
                      widget.comment['like'].contains(widget.userId)
                          ? 'assets/svg/active_heart.svg'
                          : 'assets/svg/heart.svg'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
