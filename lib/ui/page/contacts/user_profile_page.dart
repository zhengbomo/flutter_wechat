import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/constants/shares.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/ui/components/avatar.dart';
import 'package:flutterwechat/ui/components/common_arrow.dart';
import 'package:flutterwechat/ui/view/bm_appbar.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMAppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
                Constant.assetsImagesChat.named("icons_filled_more.svg")),
            onPressed: () {},
          )
        ],
      ),
      body: MediaQuery(
        data: MediaQueryData(
          padding: EdgeInsets.only(bottom: 500),
        ),
        child: ListView(
          children: <Widget>[
            _createHeader(),
            _createDivider(),
            _createItem(
              "标签",
              content: Text(
                "我的家人,公司的人",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            _createDivider(),
            _createItem("朋友权限"),
            SizedBox(height: 8),
            _createItem(
              "朋友圈",
              content: Padding(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                child: Wrap(
                  spacing: 6,
                  children: <Widget>[
                    Avatar(
                      color: Shares.randomColor.randomColor(),
                      size: 50,
                      borderRadius: 6,
                    ),
                    Avatar(
                      color: Shares.randomColor.randomColor(),
                      size: 50,
                      borderRadius: 6,
                    ),
                    Avatar(
                      color: Shares.randomColor.randomColor(),
                      size: 50,
                      borderRadius: 6,
                    ),
                    Avatar(
                      color: Shares.randomColor.randomColor(),
                      size: 50,
                      borderRadius: 6,
                    )
                  ],
                ),
              ),
            ),
            _createDivider(),
            _createItem("更多信息"),
            SizedBox(height: 8),
            _createButton(
                Constant.assetsImagesContacts.named("icons_outlined_chats.svg"),
                "发消息",
                () {}),
            _createDivider(),
            _createButton(
                Constant.assetsImagesContacts
                    .named("icons_outlined_videocall.svg"),
                "音视频通话",
                () {}),
          ],
        ),
      ),
    );
  }

  _createButton(String icon, String title, VoidCallback onPressed) {
    return Container(
      color: Colors.white,
      height: Constant.kNormalCellMinHeight,
      child: FlatButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: SvgPicture.asset(
                  icon,
                  color: Style.highlightTextColor,
                  width: 24,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Style.highlightTextColor,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          onPressed: onPressed),
    );
  }

  _createDivider() {
    return Divider(
      height: 0.5,
      indent: 24,
      thickness: 0.5,
    );
  }

  _createItem(String title, {Widget content, VoidCallback onPressed}) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 60),
      child: FlatButton(
        padding: EdgeInsets.only(left: 24, right: 24),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 80,
              child: Text(
                title,
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: content ?? SizedBox(),
            ),
            CommonArrow(),
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  _createHeader() {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.zero,
              child: Avatar(
                color: Colors.blue,
                borderRadius: 6,
                size: 72,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "八戒",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Image.asset(
                            Constant.assetsImagesContacts
                                .named("contact_male.png"),
                            width: 24,
                          ),
                        )
                      ],
                    ),
                    Text(
                      "微信号：a-jiao",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "地区：中国大陆",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
