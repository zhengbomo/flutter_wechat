import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterwechat/data/models/chat_message_info.dart';


class ChatMessageModel extends ChangeNotifier {
  var messages = List<ChatMessageInfo>();

  ChatMessageModel() {
    messages.addAll(List.generate(20, (index) => 
      ChatMessageInfo<String>()
        ..messageId = index + 1
        ..content = randomContent()
        ..messageType = 1
        ..avatar = ""
        ..username = "bomo"
        ..date = DateTime.now()
        ..userType = 1
    ));
  }

  String randomContent() {
    const list = [
      "今天下午吃什么啊",
      "今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊",
      "今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊啊今天下午吃什么啊",
      "今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊",
      "今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊",
      "今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午吃什么啊今天下午啊今天下午吃什么啊",
      ];
    var i = Random().nextInt(list.length);
    return list[i];
  }
}


