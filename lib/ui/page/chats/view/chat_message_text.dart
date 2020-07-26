import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/models/chat_message_info.dart';

class ChatMessageText extends StatelessWidget {
  final ChatMessageInfo message;

  ChatMessageText({this.message});

  @override
  Widget build(BuildContext context) {
    double left;
    double right;
    switch (this.message.userType) {
      case MessageUserType.me:
        right = -10.0 + 2;
        break;
      case MessageUserType.other:
        left = 0.0 + 2;
        break;
    }
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        // 箭头
        Positioned(
          right: right,
          left: left,
          top: 15,
          child: Container(
            transform: Matrix4.identity()..rotateZ(pi / 4),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.5),
              color: Colors.green,
            ),
          ),
        ),
        // 内容
        Container(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(3)),
          child: Text(
            message.content,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
