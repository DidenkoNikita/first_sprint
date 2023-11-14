import 'package:flutter/material.dart';
import 'package:evently_sprint/features/chat_page/widgets/widgets.dart';
import 'package:evently_sprint/requests/message_is_read/request.dart';
import 'package:evently_sprint/requests/get_chat_id/request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.name, required this.friendId})
      : super(key: key);

  final String name;
  final int friendId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int? chatId;
  late io.Socket socket;
  var id;
  List<dynamic> messageList = [];

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
    socket.emit("getMessageList", chatId);
    socket.on(
      "messageList",
      (data) {
        setState(() {
          messageList =
              data.where((message) => message['chat_id'] == chatId).toList();
          print(messageList);
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchChatId();
    initializeSocket();
  }

  Future<void> _fetchChatId() async {
    try {
      final response = await GetChatId(friendId: widget.friendId).getChatId();
      setState(() {
        chatId = response['id'];
        print('chat id:: $chatId');
      });
    } catch (e) {
      debugPrint('Ошибка при получении chatId: $e');
    }
  }

  void _addMessage(Map<String, dynamic> message) {
    setState(() {
      messageList.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    messageList.sort((a, b) => a['id'].compareTo(b['id']));
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
              ).then((value) => value.toList()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    children: snapshot.data ?? [],
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
