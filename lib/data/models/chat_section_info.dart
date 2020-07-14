import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/shares.dart';

class ChatSectionInfo {
  int sectionId;
  String title;
  String desc;
  Color avatar;
  DateTime date;
  String badge;
  // 免打扰
  bool isMute;
  // 其他数据

  static int _count = 1;
  static final _random = Random();
  static ChatSectionInfo random() {
    final ran = _random.nextInt(10);
    String badge;
    switch (ran) {
      case 1:
        badge = "";
        break;
      case 2:
        badge = "${_random.nextInt(99)}";
        break;
      default:
        break;
    }

    final section = ChatSectionInfo();
    section.isMute = _random.nextBool();
    section.sectionId = _count++;
    section.avatar = Shares.randomColor.randomColor();
    section.title = "八戒";
    section.desc = "今天中午吃什么";
    section.date =
        DateTime.now().add(Duration(minutes: _random.nextInt(10000)));
    section.badge = badge;
    return section;
  }
}
