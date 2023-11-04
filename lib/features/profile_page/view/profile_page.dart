// ignore_for_file: deprecated_member_use

import 'package:evently_sprint/requests/get_user/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evently_sprint/features/components/home_footer.dart';
import 'package:evently_sprint/features/profile_page/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool avatarClick = false;
  Future user = GetUser().getUser();

  @override
  void initState() {
    super.initState();
    user = GetUser().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileHeader(),
      body: FutureBuilder<dynamic>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic> user = snapshot.data!;
            String capitalize(String s) {
              return s[0].toUpperCase() + s.substring(1);
            }

            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/png/background_comments.png'),
                  repeat: ImageRepeat.repeat,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          avatarClick = !avatarClick;
                        });
                      },
                      child: avatarClick
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 366,
                                  height: 680,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(30, 30, 30, 1),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      user['user']['name'].substring(0, 1),
                                      style: const TextStyle(
                                        fontSize: 128,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Container(
                              width: 134,
                              height: 134,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromRGBO(30, 30, 30, 1),
                                border: Border.all(
                                  color: const Color.fromRGBO(48, 48, 48, 1),
                                  width: 10,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  user['user']['name'].substring(0, 1),
                                  style: const TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(48, 48, 48, 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 25,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(170, 170, 170, 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 27,
                            ),
                            Text(
                              user['user']['name'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 37,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/city.svg',
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  user['user']['city'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(170, 170, 170, 1),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 10,
                              runSpacing: 20,
                              alignment: WrapAlignment.start,
                              children: [
                                if (user['userCategories'] != null)
                                  for (var entry
                                      in user['userCategories'].entries)
                                    if (entry.value)
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                223, 197, 255, 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          child: Text(
                                            capitalize(entry.key
                                                .replaceAll('_', ' ')
                                                .toLowerCase()),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Mood',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 10,
                              runSpacing: 20,
                              alignment: WrapAlignment.start,
                              children: [
                                if (user['userMood'] != null)
                                  for (var entry in user['userMood'].entries)
                                    if (entry.value)
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                223, 197, 255, 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          child: Text(
                                            capitalize(entry.key
                                                .replaceAll('_', ' ')
                                                .toLowerCase()),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 365,
                              height: 48,
                              padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(30, 30, 30, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/svg/bookmark.svg'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Subscriptions',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    '456',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(170, 170, 170, 1),
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    margin: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                        'assets/svg/chevron-right.svg'),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 365,
                              height: 48,
                              padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(30, 30, 30, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/svg/user-curcle.svg'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Friends',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    '548',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(170, 170, 170, 1),
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    margin: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                        'assets/svg/chevron-right.svg'),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 365,
                              height: 48,
                              padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(30, 30, 30, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/heart.svg',
                                    color:
                                        const Color.fromRGBO(187, 131, 255, 1),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Favourites',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    '463',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(170, 170, 170, 1),
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    margin: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                        'assets/svg/chevron-right.svg'),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 365,
                              height: 48,
                              child: Row(
                                children: [
                                  const Text(
                                    'City',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    user['user']['city'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 1,
                              height: 1,
                            ),
                            SizedBox(
                              width: 365,
                              height: 48,
                              child: Row(
                                children: [
                                  const Text(
                                    'Phone number',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    user['user']['phone'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(187, 131, 255, 1),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 1,
                              height: 1,
                            ),
                            const SizedBox(
                              width: 365,
                              height: 48,
                              child: Row(
                                children: [
                                  Text(
                                    'E-mail',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'full.name@gmail.com',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(187, 131, 255, 1),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 1,
                              height: 1,
                            ),
                            SizedBox(
                              width: 365,
                              height: 48,
                              child: Row(
                                children: [
                                  const Text(
                                    'Date of Birth',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    user['user']['date_of_birth'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 1,
                              height: 1,
                            ),
                            SizedBox(
                              width: 365,
                              height: 48,
                              child: Row(
                                children: [
                                  const Text(
                                    'Gender',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    user['user']['gender'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 1,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: const HomeFooter(),
    );
  }
}
