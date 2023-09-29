import 'package:evently_sprint/requests/get_posts/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  var croppingText = false;
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  void initPreferences() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int userId = preferences.getInt('userId') ?? 0;
    print(userId);
    return FutureBuilder(
        future: GetPosts().getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Text('Ошибка загрузки данных');
          } else {
            List<Map<String, dynamic>> posts =
                snapshot.data as List<Map<String, dynamic>>;
            return Column(
              children: posts.map((item) {
                bool like = item['like'].contains(userId);
                print(like);
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
                                                color: const Color.fromRGBO(
                                                    24, 24, 24, 1),
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
                                                  item['link_avatar'],
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Добавил это свойство
                                    children: [
                                      Text(
                                        item['user_name'],
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
                                        item['type'],
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
                        item['link_photo'],
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
                                onPressed: () {},
                                icon: SvgPicture.asset(like
                                    ? 'assets/svg/active_heart.svg'
                                    : 'assets/svg/heart.svg'),
                              ),
                              Text(
                                '${item['like'].length}',
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
                                icon:
                                    SvgPicture.asset('assets/svg/comments.svg'),
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
                                      text: item['user_name'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const TextSpan(text: ' '),
                                    TextSpan(
                                      text: item['title'].toString().length >=
                                              130
                                          ? '${item['title'].substring(0, 130)}...'
                                          : item['title'],
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
                                          color:
                                              Color.fromRGBO(170, 170, 170, 1),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()),
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
              }).toList(),
            );
          }
        });
  }
}
