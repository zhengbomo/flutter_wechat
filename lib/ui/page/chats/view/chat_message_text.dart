import 'package:flutter/material.dart';
import 'package:flutterwechat/data/models/chat_message_info.dart';

class ChatMessageText extends StatelessWidget {
  final ChatMessageInfo message;

  ChatMessageText({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(3)),
        child: Text(
          message.content,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ));
  }
}
