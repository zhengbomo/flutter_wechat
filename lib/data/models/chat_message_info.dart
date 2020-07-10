import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum MessageUserType { me, other }

enum MessageType { text, image, voice }

class ChatMessageInfo<T> {
  int messageId;
  T content;
  int messageType;
  String avatar;
  String username;
  MessageUserType userType;
  DateTime date;
  Color color;
  double height;
}
