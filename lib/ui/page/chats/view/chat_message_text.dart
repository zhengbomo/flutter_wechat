import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/models/chat_message_info.dart';

class ChatMessageText extends StatelessWidget {
  final ChatMessageInfo message;

  ChatMessageText({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          // color: Colors.green,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            // Image.network(
            //   "https://upload.jianshu.io/users/upload_avatars/3884536/d847a50f1da0.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240",
            //   width: 100,
            //   height: 100,
            //   fit: BoxFit.contain,
            //   centerSlice: Rect.fromLTWH(10, 10, 10, 10),
            // ),
            Positioned(
                child: Image.asset(
                  Constant.assetsImagesChat
                      .named("chatroom_bubble_receiver.png"),
                  fit: BoxFit.fill,
                  centerSlice:
                      Rect.fromCircle(center: const Offset(60, 100), radius: 1),
                ),
                left: 0.0,
                right: 0.0,
                top: 0.0,
                bottom: 0.0),
            new Container(
                child: new Text(message.content,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center),
                padding: const EdgeInsets.fromLTRB(2.0, 2.0, 32.0, 2.0))
          ],
        ));
  }
}
