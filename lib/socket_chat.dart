import 'package:first_app/controller.dart';
import 'package:first_app/internet.dart';
import 'package:first_app/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketChat extends StatefulWidget {
  const SocketChat({Key? key}) : super(key: key);

  @override
  State<SocketChat> createState() => _SocketChatState();
}

class _SocketChatState extends State<SocketChat> {
  final TextEditingController messageController = TextEditingController();
  late IO.Socket socket;
  ChatController chatController = ChatController();

  @override
  void initState() {
    socket = IO.io(
        // 'http://10.0.2.2:5000',
        'http://localhost:5000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    setUpSocketListener();
    // socket.on('connect', (_) => print('connected to socket'));
    // setUpSocketListener();
    super.initState();
  }

  void setUpSocketListener() {
    socket.on('message-received', (data) {
      chatController.chatMessages.add(Message.fromJson(data));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    messageController.dispose();
    super.dispose();
  }

  messageBox(
    String message,
    bool isMe,
  ) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: isMe
                ? EdgeInsets.only(top: 10, bottom: 10, left: 18, right: 8)
                : EdgeInsets.only(top: 10, bottom: 10, right: 18, left: 8),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                color: isMe
                    ? Theme.of(context).primaryColor
                    : Color.fromARGB(255, 42, 87, 88).withOpacity(0.7),
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      )),
            child: isMe
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                          '2pm',
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(message,
                            style: TextStyle(
                              color: Color.fromARGB(179, 254, 254, 254),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            )),
                      ])
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text('3pm',
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            )),
                        // SizedBox(height: 5),
                        Text(message,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )),
                      ]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text('Socket chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              itemCount: chatController.chatMessages.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = chatController.chatMessages[index];
                                bool isMe = item.sentByMe == socket.id;
                                var message = item.message;
                                var id = socket.id;
                                print('Message = $message and Id= $id, $isMe');

                                return messageBox(message, isMe);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Color(0xFF512E5F),
                    Colors.teal,
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
            child: Row(children: [
              IconButton(
                icon: Icon(Icons.photo),
                iconSize: 22,
                color: Colors.white,
                onPressed: () {},
              ),
              Expanded(
                child: TextField(
                  minLines: 1,
                  maxLines: 6,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Send a message...',
                      hintStyle: TextStyle(color: Colors.white54)),
                  autocorrect: true,
                  controller: messageController,
                ),
              ),
              IconButton(
                  icon: Icon(Icons.send),
                  color: Colors.white,
                  iconSize: 22,
                  onPressed: () async {
                    var msgJson = {
                      "message": messageController.text,
                      "sentBy": socket.id ?? 'noId',
                    };

                    socket.emit('message', msgJson);

                    chatController.chatMessages.add(Message.fromJson(msgJson));
                    messageController.text = '';
                  }),
            ]),
          ),
        ],
      ),
    );
  }
}
