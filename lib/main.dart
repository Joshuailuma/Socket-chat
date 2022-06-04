import 'package:first_app/rooms/room_list.dart';
import 'package:first_app/socket_chat.dart';
import 'package:flutter/material.dart';

import 'node_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RoomList(),
    );
  }
}
