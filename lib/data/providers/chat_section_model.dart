import 'package:flutter/material.dart';
import 'package:flutterwechat/data/models/chat_section_info.dart';

class ChatSectionModel extends ChangeNotifier {
  var sections = List<ChatSectionInfo>();

  ChatSectionModel() {
    sections.addAll(List.generate(20, (index) => ChatSectionInfo.random()));
  }
}
