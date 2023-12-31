import 'package:flutter/material.dart';
import 'package:evently_sprint/features/chat_page/widgets/widgets.dart';
import 'package:evently_sprint/requests/message_is_read/request.dart';
import 'package:evently_sprint/requests/get_chat_id/request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.name,
    required this.friendId,
    required this.updateChatsList,
  }) : super(key: key);

  final String name;
  final int friendId;
  final Function(List<dynamic>) updateChatsList;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int? chatId;
  late io.Socket socket;
  late int id;
  List<dynamic> messageList = [];

  @override
  void initState() {
    super.initState();
    _fetchChatId();
    _initializeSocket();
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  Future<void> _initializeSocket() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');
    setState(() {
      id = userId!;
    });
    await dotenv.load();
    String? api = dotenv.env['SERVER_API'];
    socket = io.io('ws://${api.toString()}/chat', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.emit("getChats", id);
    socket.on(
      "chatData",
      (data) => {
        setState(() {
          List<dynamic> updatedList = List.from(data)
            ..sort((a, b) {
              DateTime dateA = DateTime.parse(a['timeMessage']);
              DateTime dateB = DateTime.parse(b['timeMessage']);
              return dateB.compareTo(dateA);
            });
          widget.updateChatsList(updatedList);
        })
      },
    );
    socket.emit("getMessageList", chatId);
    socket.on(
      "messageList",
      (data) {
        setState(() {
          if (chatId != null) {
            messageList =
                data.where((message) => message['chat_id'] == chatId).toList();
          }
        });
      },
    );
    socket.on(
      "createMessage",
      (message) {
        if (mounted) {
          if (chatId != null &&
              message['chat_id'] == chatId &&
              !messageList.any((m) => m['id'] == message['id'])) {
            setState(() {
              messageList.add(message);
            });
          }
        }
      },
    );
    socket.on(
      "updateChat",
      (chat) => {
        setState(() {
          List<dynamic> updatedList = List.from(chat)
            ..sort((a, b) {
              DateTime dateA = DateTime.parse(a['timeMessage']);
              DateTime dateB = DateTime.parse(b['timeMessage']);
              return dateB.compareTo(dateA);
            });
          widget.updateChatsList(updatedList);
        })
      },
    );
  }

  Future<void> _fetchChatId() async {
    try {
      final response = await GetChatId(friendId: widget.friendId).getChatId();
      setState(() {
        chatId = response['id'];
      });
    } catch (e) {
      debugPrint('Ошибка при получении chatId: $e');
    }
  }

  void _addMessage(Map<String, dynamic> message) {
    if (chatId != null &&
        message['chat_id'] == chatId &&
        !messageList.any((m) => m['id'] == message['id'])) {
      setState(() {
        messageList.add(message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatHeader(name: widget.name),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/png/background_comments.png'),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: FutureBuilder<List<Widget>>(
              future: Future.wait(
                messageList.map<Future<Widget>>((message) async {
                  if (message['user_id'] != id && !message['is_read']) {
                    final readMessage = await MessageIsRead(
                      id: message['id'],
                      userId: message['user_id'],
                    ).messageIsRead();
                    return Message(message: readMessage, id: id);
                  }
                  return Message(message: message, id: id);
                }),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    children: [
                      ...(snapshot.data ?? []),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: ChatFooter(
        id: id,
        chatId: chatId,
        addMessage: _addMessage,
      ),
    );
  }
}
