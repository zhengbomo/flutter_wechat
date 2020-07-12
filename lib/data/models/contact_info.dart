import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/shares.dart';
import 'package:tuple/tuple.dart';

class ContactInfo {
  Color avatar;
  String name;
  String tagIndex;

  static ContactInfo random() {
    const names = [
      Tuple2('A', '阿福'),
      Tuple2('A', '阿胶'),
      Tuple2('A', '阿珍'),
      Tuple2('B', '八戒'),
      Tuple2('B', 'Bash'),
      Tuple2('B', 'BIM'),
      Tuple2('D', '大眼猫'),
      Tuple2('D', '冬瓜'),
      Tuple2('X', '小菜'),
      Tuple2('X', '小明'),
      Tuple2('#', '😇'),
      Tuple2('#', '😐'),
      Tuple2('#', '😑'),
      Tuple2('#', '😶'),
      Tuple2('#', '😏'),
      Tuple2('#', '😣'),
      Tuple2('#', '😞'),
      Tuple2('#', '😟'),
      Tuple2('#', '😤'),
      Tuple2('#', '😢'),
      Tuple2('#', '😭'),
      Tuple2('#', '😦'),
      Tuple2('#',
          '😇😐😑😶😏😣😥😮😯😪😫😴😌😛😜😝😒😓😔😕😲😷😖😞😟😤😢😭😦😧😨😬😰😱😳😵😡'),
    ];

    var info = ContactInfo();
    info.avatar = Shares.randomColor.randomColor();

    final item = names.elementAt(Shares.random.nextInt(names.length));
    info.tagIndex = item.item1;
    info.name = item.item2;
    return info;
  }
}
