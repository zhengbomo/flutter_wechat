import 'package:flutter/material.dart';
import 'package:flutterwechat/data/models/chat_section_info.dart';


class ChatSectionModel extends ChangeNotifier {
  var sections = List<ChatSectionInfo>();

  ChatSectionModel() {
    sections.addAll(List.generate(20, (index) => 
      ChatSectionInfo()
        ..sectionId = 1
        ..title = "傻古1105"
        ..desc = "今天下午吃什么啊"
        ..date = DateTime.now()
        ..icon = ""
        ..badge = "1"
    ));
    // section.addAll([
      
    //   ChatSectionInfo()
    //     ..sectionId = 1
    //     ..title = ""
    //     ..desc = ""
    //     ..date = DateTime.now()
    //     ..icon = ""
    //     ..badge = "",
    //   ChatSectionInfo()
    //     ..sectionId = 1
    //     ..title = ""
    //     ..desc = ""
    //     ..date = DateTime.now()
    //     ..icon = ""
    //     ..badge = "",
    // ]);
  }
}


