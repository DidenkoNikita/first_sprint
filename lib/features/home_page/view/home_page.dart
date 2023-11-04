import 'package:evently_sprint/features/components/home_footer.dart';
import 'package:evently_sprint/features/home_page/widgets/widgets.dart';
import 'package:evently_sprint/requests/get_comments/get_comments.dart';
import 'package:evently_sprint/requests/get_posts/get_posts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Stories(),
            const SizedBox(height: 20),
            const CalendarOfEventsHome(),
            const SizedBox(height: 20),
            FutureBuilder(
              future: Future.wait([
                GetPosts().getPosts(),
                GetComments().getComments(),
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const Text('Ошибка загрузки данных');
                } else {
                  List<Map<String, dynamic>> posts = (snapshot.data?[0]
                      as List<Map<String, dynamic>>)
                    ..sort(
                        (a, b) => (a['id'] as int).compareTo(b['id'] as int));

                  List<Map<String, dynamic>> comments =
                      snapshot.data?[1] as List<Map<String, dynamic>>;
                  return Column(
                    children: posts.map((item) {
                      List<Map<String, dynamic>> foundComments = comments
                          .where((comment) => comment['post_id'] == item['id'])
                          .toList();
                      foundComments.sort(
                          (a, b) => (a['id'] as int).compareTo(b['id'] as int));
                      return PostItem(post: item, comments: foundComments);
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeFooter(),
    );
  }
}
