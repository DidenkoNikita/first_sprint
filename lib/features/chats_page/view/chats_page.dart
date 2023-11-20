// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables

import 'package:evently_sprint/features/chat_page/view/view.dart';
import 'package:evently_sprint/features/chats_page/widgets/widgets.dart';
import 'package:evently_sprint/features/components/home_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  var chatsList = [];
  late io.Socket socket;
  var id;

  String _formatNumber(int num) {
    return num.toString().padLeft(2, '0');
  }

  void updateChatsList(List<dynamic> updatedList) {
    setState(() {
      chatsList = updatedList;
    });
  }

  Future<void> initializeSocket() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');
    setState(() {
      id = userId;
    });
    await dotenv.load();
    String? api = dotenv.env['SERVER_API'];
    var socket = io.io('ws://${api.toString()}/chat', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.emit('getChats', userId);
    socket.on('chatData', (data) {
      setState(() {
        chatsList = List.from(data)
          ..sort((a, b) {
            DateTime dateA = DateTime.parse(a['timeMessage']);
            DateTime dateB = DateTime.parse(b['timeMessage']);
            return dateB.compareTo(dateA);
          });
      });
    });

    socket.on('createChat', (chatData) {
      debugPrint("new chat created $chatData");
    });
  }

  @override
  void initState() {
    super.initState();
    initializeSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatsHeader(
        updateChatsList: updateChatsList,
        chatsList: chatsList,
      ),
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
                height: 30,
              ),
              Column(
                children: [
                  for (var chat in chatsList) ...[
                    InkWell(
                      onTap: () {
                        final int friendId = (List<int>.from(chat['users_id']))
                            .firstWhere((idUser) => idUser != id);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(
                                  name: chat['name'],
                                  friendId: friendId,
                                  updateChatsList: updateChatsList,
                                )));
                      },
                      child: SizedBox(
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
                                      chat['name'].substring(0, 1),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chat['name'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      (chat['textMessage'] != null &&
                                              chat['textMessage']!.length < 20)
                                          ? chat['textMessage']!
                                          : '${chat['textMessage']?.substring(0, 20) ?? ''}...',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        if (chat['userId'] != null &&
                                            chat['isReadMessage'] != null)
                                          if (id == chat['userId'])
                                            SvgPicture.asset(
                                              'assets/svg/double-checkmark.svg',
                                              color: chat['isReadMessage']
                                                  ? const Color.fromRGBO(
                                                      227, 245, 99, 1)
                                                  : const Color.fromRGBO(
                                                      170, 170, 170, 1),
                                            ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          chat['timeMessage'] != null
                                              ? '${_formatNumber(DateTime.parse(chat['timeMessage']).hour)}:${_formatNumber(DateTime.parse(chat['timeMessage']).minute)}'
                                              : '',
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    if (chat['unreadMessages'] != null)
                                      if (id != chat['userId'] ||
                                          chat['userId'] != null)
                                        Container(
                                          width: 25,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromRGBO(
                                                227, 245, 99, 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              chat['unreadMessages'].toString(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        )
                                  ],
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
                    ),
                  ]
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
