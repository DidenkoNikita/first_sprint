import 'package:evently_sprint/features/components/home_footer.dart';
import 'package:evently_sprint/features/write_message_page/widgets/widgets.dart';
import 'package:evently_sprint/requests/get_user_list/get_user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WriteMessagePage extends StatefulWidget {
  const WriteMessagePage({Key? key}) : super(key: key);

  @override
  State<WriteMessagePage> createState() => _WriteMessagePageState();
}

class _WriteMessagePageState extends State<WriteMessagePage> {
  dynamic userList = [];

  @override
  void initState() {
    super.initState();
    _fetchUserList();
  }

  Future<void> _fetchUserList() async {
    try {
      dynamic fetchedUserList = await GetUserList().getUserList();
      print(fetchedUserList);
      setState(() {
        userList = fetchedUserList;
      });
    } catch (e) {
      print('Ошибка при получении списка пользователей: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WriteMessageHeader(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Column(
            children: [
              Container(
                width: 365,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(36, 36, 36, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.all(10),
                        child: SvgPicture.asset('assets/svg/search.svg'),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  for (var user in userList)
                    SizedBox(
                      width: 365,
                      height: 59,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color.fromRGBO(36, 36, 36, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    user['name'].substring(0, 1),
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
                              Text(
                                user['name'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 24,
                                height: 24,
                                margin: const EdgeInsets.all(10),
                                child: SvgPicture.asset(
                                    'assets/svg/phone-call.svg'),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(223, 197, 255, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    'assets/svg/chats.svg',
                                    // ignore: deprecated_member_use
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Divider(
                              color: Color.fromRGBO(24, 24, 24, 1),
                              thickness: 1,
                              height: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const HomeFooter(),
    );
  }
}
