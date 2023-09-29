import 'package:evently_sprint/requests/get_stories/reguest.dart';
import 'package:flutter/material.dart';

class Stories extends StatefulWidget {
  const Stories({super.key});

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetStories().getStories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          return const Text('Ошибка загрузки данных');
        } else {
          List<Map<String, dynamic>> stories =
              snapshot.data as List<Map<String, dynamic>>;
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: stories.map((item) {
                return Column(
                  children: [
                    const SizedBox(
                      width: 90.0,
                    ),
                    Container(
                      width: 78,
                      height: 78,
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
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color.fromRGBO(24, 24, 24, 1),
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: Container(
                                  width: 72,
                                  height: 72,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    item['link'],
                                    fit: BoxFit.cover,
                                    width: 72,
                                    height: 72,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      item['title'].toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
