import 'package:flutter/material.dart';
import 'package:flutterwechat/data/models/chat_message_info.dart';


class ChatMessageModel extends ChangeNotifier {
  var messages = List<ChatMessageInfo>();

  ChatMessageModel() {
    messages.addAll(List.generate(20, (index) => 
      ChatMessageInfo<String>()
        ..messageId = index + 1
        ..content = "今天下午吃什么啊"
        ..messageType = 1
        ..avatar = ""
        ..username = "bomo"
        ..date = DateTime.now()
        ..userType = 1
    ));
  }
}


