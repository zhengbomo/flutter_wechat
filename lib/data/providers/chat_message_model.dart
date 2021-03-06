import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/shares.dart';
import 'package:flutterwechat/data/models/chat_message_info.dart';

class ChatMessageModel extends ChangeNotifier {
  // 用于标识message的变化
  int messageChangedId = 0;

  List<ChatMessageInfo> messages = List<ChatMessageInfo>();
  ChatMessageModel() {
    messages.addAll(List.generate(
        10,
        (index) => ChatMessageInfo<String>()
          ..messageId = index + 1
          ..content = randomContent()
          ..messageType = 1
          ..avatar = ""
          ..username = "bomo"
          ..color = Shares.randomColor.randomColor()
          ..date = DateTime.now()
          ..height = 30.0 + Shares.random.nextInt(200)
          ..userType = MessageUserType.values[Shares.random.nextInt(2)]));
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
    var i = Shares.random.nextInt(list.length);
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
          ..color = Shares.randomColor.randomColor()
          ..username = "bomo"
          ..date = DateTime.now()
          ..height = 100.0 + Shares.random.nextInt(100)
          ..userType = MessageUserType.values[Shares.random.nextInt(2)]);
    messages.insertAll(0, list);
    messageChangedId++;
    notifyListeners();
    return list;
  }

  List<ChatMessageInfo> addMessage(int count) {
    var list = List.generate(
        count,
        (index) => ChatMessageInfo<String>()
          ..messageId = index + 1
          ..content = randomContent()
          ..messageType = 1
          ..avatar = ""
          ..color = Shares.randomColor.randomColor()
          ..username = "bomo"
          ..date = DateTime.now()
          ..height = 100.0 + Shares.random.nextInt(100)
          ..userType = MessageUserType.values[Shares.random.nextInt(2)]);
    messages.addAll(list);
    messageChangedId++;
    notifyListeners();
    return list;
  }
}
