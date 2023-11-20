import 'package:evently_sprint/features/change_photo_page/view/view.dart';
import 'package:evently_sprint/features/components/home_footer.dart';
import 'package:evently_sprint/features/profile_settings_page/widgets/widgets.dart';
import 'package:evently_sprint/requests/get_user/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  Future user = GetUser().getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileSettingsHeader(),
      body: FutureBuilder<dynamic>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic> user = snapshot.data;
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/png/background_comments.png'),
                  repeat: ImageRepeat.repeat,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangePhotoPage(user: user),
                        ));
                      },
                      child: Container(
                        width: 365,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(48, 48, 48, 1),
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                        child: Row(
                          children: [
                            const Text(
                              'My photo',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 24,
                              height: 24,
                              margin: const EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                  'assets/svg/chevron-right.svg'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 365,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(48, 48, 48, 1),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                      child: Row(
                        children: [
                          const Text(
                            'Personal data',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                'assets/svg/chevron-right.svg'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 365,
                      height: 97,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(48, 48, 48, 1),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Row(
                              children: [
                                const Text(
                                  'Change number',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  user['user']['phone'],
                                  style: const TextStyle(
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
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Divider(
                              thickness: 1,
                              height: 1,
                              color: Color.fromRGBO(24, 24, 24, 1),
                            ),
                          ),
                          SizedBox(
                            height: 48,
                            child: Row(
                              children: [
                                const Text(
                                  'Change E-mail',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  'full.name@gmail.com',
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 365,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(48, 48, 48, 1),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                      child: Row(
                        children: [
                          const Text(
                            'Change city',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            user['user']['city'],
                            style: const TextStyle(
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
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 365,
                      height: 97,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(48, 48, 48, 1),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Row(
                              children: [
                                const Text(
                                  'Change categories',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 24,
                                  height: 24,
                                  margin: const EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                      'assets/svg/chevron-right.svg'),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Divider(
                              thickness: 1,
                              height: 1,
                              color: Color.fromRGBO(24, 24, 24, 1),
                            ),
                          ),
                          SizedBox(
                            height: 48,
                            child: Row(
                              children: [
                                const Text(
                                  'Change your mood',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 24,
                                  height: 24,
                                  margin: const EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                      'assets/svg/chevron-right.svg'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 365,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(48, 48, 48, 1),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                      child: Row(
                        children: [
                          const Text(
                            'Change password',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                'assets/svg/chevron-right.svg'),
                          ),
                        ],
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
