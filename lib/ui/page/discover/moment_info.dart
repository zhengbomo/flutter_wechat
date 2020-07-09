import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/shares.dart';

class MomentInfo {
  Color avatar;
  String username;
  String content;
  List<Color> images;
  String location;
  DateTime time;
  List<String> likes;
  List<String> comments;

  MomentInfo();

  factory MomentInfo.random() {
    return MomentInfo()
      ..username = "八戒"
      ..avatar = Shares.randomColor.randomColor()
      ..content = "今天中午吃什么"
      ..location = "广州市"
      ..time = DateTime.now().add(Duration(hours: -Shares.random.nextInt(1000)))
      ..images = List.generate(
          Shares.random.nextInt(6), (index) => Shares.randomColor.randomColor())
      ..likes = ["蜗牛骑士", "马化腾", "刘强东", "马云"]
      ..comments = ["牛逼🐮", "哈哈哈", "今天晚上吃什么今天晚上吃什么今天晚上吃什么今天晚上吃什么今天晚上吃什么"];
  }
}
