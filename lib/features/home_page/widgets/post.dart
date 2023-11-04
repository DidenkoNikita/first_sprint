// ignore_for_file: unnecessary_null_comparison

import 'package:evently_sprint/features/comments/view/view.dart';
import 'package:evently_sprint/requests/like_post/request.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostItem extends StatefulWidget {
  final Map<String, dynamic> post;
  final List<Map<String, dynamic>> comments;

  const PostItem({Key? key, required this.post, required this.comments})
      : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool croppingText = false;
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  void initPreferences() async {
    preferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (preferences == null) {
      return const CircularProgressIndicator();
    }

    int userId = preferences.getInt('userId') ?? 0;
    return Container(
      width: 433,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(36, 36, 36, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 433,
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 39,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      Container(
                        width: 39,
                        height: 39,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(39),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(187, 131, 255, 1),
                              Color.fromRGBO(187, 131, 255, 1),
                              Color.fromRGBO(227, 245, 99, 1),
                              Color.fromRGBO(227, 245, 99, 1),
                              Color.fromRGBO(227, 245, 99, 1),
                            ],
                            stops: [0.0, 0.2, 0.4, 0.6, 1.0],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            transform: GradientRotation(100),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color.fromRGBO(24, 24, 24, 1),
                                    width: 1.5,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Container(
                                    width: 34,
                                    height: 34,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      widget.post['link_avatar'],
                                      fit: BoxFit.cover,
                                      width: 34,
                                      height: 34,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post['user_name'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            widget.post['type'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                  child: const Text(
                    'Subscribe',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(187, 131, 255, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.network(
            widget.post['link_photo'],
            width: 433,
            height: 345,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 14,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final post =
                          await LikePost(postId: widget.post['id']).likePost();
                      setState(() {
                        widget.post['like'] = post['like'];
                      });
                    },
                    icon: SvgPicture.asset(widget.post['like'].contains(userId)
                        ? 'assets/svg/active_heart.svg'
                        : 'assets/svg/heart.svg'),
                  ),
                  Text(
                    '${widget.post['like'].length}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CommentsPage(
                          post: widget.post,
                          comments: widget.comments,
                          userId: userId,
                        ),
                      ));
                    },
                    icon: SvgPicture.asset('assets/svg/comments.svg'),
                  ),
                  Text(
                    '${widget.comments.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/svg/share.svg'),
                  ),
                  const Text(
                    '548',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.post['user_name'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: widget.post['title'].toString().length >= 150
                              ? croppingText == true
                                  ? '${widget.post['title']}'
                                  : '${widget.post['title'].substring(0, 150)}...'
                              : widget.post['title'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: croppingText ? 'less' : 'more',
                          style: const TextStyle(
                            color: Color.fromRGBO(170, 170, 170, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                croppingText = !croppingText;
                              });
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
