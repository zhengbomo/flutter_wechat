import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterwechat/data/models/chat_message_info.dart';
import 'package:random_color/random_color.dart';

class ChatMessageModel extends ChangeNotifier {
  var messages = List<ChatMessageInfo>();
  var _random = Random();
  var _randomColor = RandomColor();
  ChatMessageModel() {
    messages.addAll(List.generate(
        10,
        (index) => ChatMessageInfo<String>()
          ..messageId = index + 1
          ..content = randomContent()
          ..messageType = 1
          ..avatar = ""
          ..username = "bomo"
          ..color = _randomColor.randomColor()
          ..date = DateTime.now()
          ..height = 30.0 + _random.nextInt(200)
          ..userType = 1));
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
    var i = _random.nextInt(list.length);
    return list[i];
  }

  List<ChatMessageInfo> insertMessage(int count) {
    var list = List.generate(
        count,
        (index) => ChatMessageInfo<String>()
          ..messageId = index + 1
          ..content = randomContent()
          ..messageType = 1
          ..avatar = ""
          ..color = _randomColor.randomColor()
          ..username = "bomo"
          ..date = DateTime.now()
          ..height = 100.0 + _random.nextInt(100)
          ..userType = 1);
    messages.insertAll(0, list);
    notifyListeners();
    return list;
  }
}
