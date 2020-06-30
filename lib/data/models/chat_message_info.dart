import 'package:flutter/material.dart';

class ChatMessageInfo<T> {
  int messageId;
  T content;
  int messageType;
  String avatar;
  String username;
  int userType;
  DateTime date;
  Color color;
  double height;
}
