import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/providers/chat_section_model.dart';
import 'package:flutterwechat/data/providers/main_badge_model.dart';
import 'package:flutterwechat/data/providers/main_chat_model.dart';
import 'package:flutterwechat/ui/components/add_menu.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';
import 'package:flutterwechat/ui/page/chats/chat_section_list.dart';
import 'package:provider/provider.dart';

class MainChatPage extends StatefulWidget {
  @override
  _MainChatPageState createState() => _MainChatPageState();
}

class _MainChatPageState extends AutoKeepAliveState<MainChatPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (_) => MainChatModel(),
      child: Builder(builder: (context) {
        return Stack(
          children: <Widget>[
            _createMainView(context),
            Selector(builder: (context, show, child) {
              return AddMenu(show: show, dismissCall: () {
                context.read<MainChatModel>().setShowMenu(false);
              },);
            }, selector: (context, MainChatModel model) => model.showMenu)          
          ],
        ); 
      }),
    );
  }

  Widget _createMainView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text("微信"),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                Constant.assetsImagesMainframe.named("icons_outlined_add2.svg"),
                color: Color(0xFF181818),
              ),
              onPressed: () {
                context.read<MainChatModel>().setShowMenu(true);
              },
            )
          ]
      ),
      body: ChangeNotifierProvider(
        create: (_) => ChatSectionModel(),
        child: ChatSectionList(),
      )
    );
  }


}

