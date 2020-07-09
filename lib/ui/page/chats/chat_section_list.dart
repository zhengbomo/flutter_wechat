import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/data/models/chat_section_info.dart';
import 'package:flutterwechat/data/providers/chat_section_model.dart';
import 'package:flutterwechat/ui/page/chats/chat_detail_page.dart';
import 'package:flutterwechat/ui/page/test_page.dart';
import 'package:provider/provider.dart';

class ChatSectionList extends StatefulWidget {
  @override
  _ChatSectionListState createState() => _ChatSectionListState();
}

class _ChatSectionListState extends State<ChatSectionList> {
  @override
  Widget build(BuildContext context) {
    var model = context.watch<ChatSectionModel>();
    return ListView.separated(
      itemBuilder: (c, i) {
        return _createItem(c, model.sections[i]);
      },
      separatorBuilder: (c, i) {
        return Padding(
          padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
          child: Divider(height: 1, color: Colors.black12),
        );
      },
      itemCount: model.sections.length,
    );
  }

  Widget _createItem(BuildContext context, ChatSectionInfo info) {
    Widget badgeView;
    if (info.badge == null) {
      badgeView = null;
    } else if (info.badge == "") {
      badgeView = Positioned(
          right: -6,
          top: -3,
          child: Container(
            width: 12,
            height: 12,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Style.redBadgeColor,
                shape: BoxShape.circle,
              ),
            ),
          ));
    } else {
      badgeView = Positioned(
          right: -10,
          top: -5,
          child: Container(
              height: 16,
              decoration: BoxDecoration(
                  color: Style.redBadgeColor,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: Center(
                  child: Text("55",
                      style: TextStyle(color: Colors.white, fontSize: 12)))));
    }
    return FlatButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ChatDetailPage();
        }));
      },
      padding: EdgeInsets.all(0),
      child: Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Image.asset(
                    Constant.assetsImagesMock.named("peace_elite.png"),
                    width: 50,
                    height: 50,
                  ),
                  if (badgeView != null) badgeView,
                ],
              )),
          Expanded(
              child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        info.title,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Text(info.date.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black26,
                              fontWeight: FontWeight.normal)),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      info.desc,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.normal),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (info.isMute)
                    Padding(
                        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        child: Image.asset(
                            Constant.assetsImagesChat
                                .named("message_disable_notify_icon.png"),
                            width: 15,
                            color: Colors.black)),
                ],
              )
            ],
          )),
        ],
      ),
    );
  }
}
