import 'package:flutter/material.dart';

import '../socket_chat.dart';

class RoomList extends StatelessWidget {
  const RoomList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            onTap: (() => Navigator.push((context),
                MaterialPageRoute(builder: (builder) => SocketChat()))),
            title: Text('Room 1'),
            leading: Icon(Icons.room),
            iconColor: Colors.blue,
          ),
          Divider(),
          ListTile(
            title: Text('Room 2'),
            leading: Icon(Icons.room),
            iconColor: Colors.blue,
          ),
          Divider(),
          ListTile(
            title: Text('Room 3'),
            leading: Icon(Icons.room),
            iconColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
