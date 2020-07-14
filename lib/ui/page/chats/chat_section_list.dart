import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/data/models/chat_section_info.dart';
import 'package:flutterwechat/data/providers/chat_section_model.dart';
import 'package:flutterwechat/ui/page/chats/chat_detail_page.dart';
import 'package:provider/provider.dart';

// class ChatSectionList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var model = context.watch<ChatSectionModel>();
//     return ListView.separated(
//       itemBuilder: (c, i) {
//         return _createItem(c, model.sections[i]);
//       },
//       separatorBuilder: (c, i) {
//         return Padding(
//           padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
//           child: Divider(height: 1, color: Colors.black12),
//         );
//       },
//       itemCount: model.sections.length,
//     );
//   }
// }
