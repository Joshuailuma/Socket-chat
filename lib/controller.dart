import 'dart:async';

import 'package:first_app/model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxList<Message> chatMessages = <Message>[].obs;

  var welcomeMessage = ''.obs;
  var userState = ''.obs;
  var boolean = false.obs;

  changeStatus() {
    if (welcomeMessage.value.contains('joined')) {
      boolean.value = true;
    }
  }
}

class StreamSocket {
  final _socketResponse = StreamController<String>.broadcast();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();
