import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/shares.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:tuple/tuple.dart';

class ContactInfo {
  Color avatar;
  String name;
  String tagIndex;

  static ContactInfo random() {
    const names = [
      '阿福',
      '阿胶',
      '阿珍',
      '八戒',
      'Bash',
      'BIM',
      '大眼猫',
      '冬瓜',
      '小菜',
      '小明',
      '😇',
      '😐',
      '😑',
      '😶',
      '😏',
      '😣',
      '😞',
      '😟',
      '😤',
      '😢',
      '😭',
      '😦',
      '😇😐😑😶😏😣😥😮😯😪😫😴😌😛😜😝😒😓😔😕😲😷😖😞😟😤😢😭😦😧😨😬😰😱😳😵😡',
    ];

    var info = ContactInfo();
    info.avatar = Shares.randomColor.randomColor();

    final item = names.elementAt(Shares.random.nextInt(names.length));
    String tag =
        PinyinHelper.getFirstWordPinyin(item).substring(0, 1).toUpperCase();
    if (!RegExp("[A-Z]").hasMatch(tag)) {
      tag = "#";
    }
    info.tagIndex = tag;
    info.name = item;
    return info;
  }
}
