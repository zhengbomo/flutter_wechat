import 'package:flutter/material.dart';
import 'package:flutterwechat/data/models/chat_message_info.dart';


class ChatMessageText extends StatelessWidget {
  final ChatMessageInfo message;

  ChatMessageText({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(message.content)
    );
  }
}