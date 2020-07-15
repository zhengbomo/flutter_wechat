import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/components/common_arrow.dart';
import 'package:flutterwechat/ui/components/search_list_page.dart';
import 'package:flutterwechat/ui/view/bm_appbar.dart';

class AddFriendPage extends StatefulWidget {
  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchListPage(
        hideTabBar: false,
        searchPanel: Container(
          color: Colors.green,
        ),
        appbar: BMAppBar(
          title: Text("添加朋友"),
        ),
        builder: (BuildContext context, Widget searchBar) {
          return ListView(
            children: <Widget>[
              searchBar,
              Padding(
                padding: EdgeInsets.only(top: 12, bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("我的微信号: bomo00"),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Image.asset(
                        Constant.assetsImagesContacts
                            .named("add_friend_myqr.png"),
                        width: 20,
                      ),
                    ),
                  ],
                ),
              ),
              _createItem(
                  Constant.assetsImagesContacts
                      .named("add_friend_icon_reda.png"),
                  "雷达加朋友",
                  "添加身边朋友"),
              Divider(
                height: 0.5,
                indent: 54,
              ),
              _createItem(
                  Constant.assetsImagesContacts
                      .named("add_friend_icon_addgroup.png"),
                  "面对面建群",
                  "与身边的朋友进入同一个群聊"),
              Divider(
                height: 0.5,
                indent: 54,
              ),
              _createItem(
                  Constant.assetsImagesContacts
                      .named("add_friend_icon_scanqr.png"),
                  "扫一扫",
                  "扫描二维码名片"),
              Divider(
                height: 0.5,
                indent: 54,
              ),
              _createItem(
                  Constant.assetsImagesContacts
                      .named("add_friend_icon_contacts.png"),
                  "手机联系人",
                  "添加通讯录中的朋友"),
              Divider(
                height: 0.5,
                indent: 54,
              ),
              _createItem(
                  Constant.assetsImagesContacts
                      .named("add_friend_icon_offical.png"),
                  "公众号",
                  "获取更多咨询和服务"),
              Divider(
                height: 0.5,
                indent: 54,
              ),
              _createItem(
                  Constant.assetsImagesContacts
                      .named("add_friend_icon_search_wework.png"),
                  "企业微信",
                  "通过手机号搜索企业微信用户"),
            ],
          );
        },
      ),
    );
  }

  Widget _createItem(String icon, String title, String desc) {
    return SizedBox(
      height: 68,
      child: FlatButton(
        color: Colors.white,
        padding: EdgeInsets.zero,
        onPressed: () {},
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Image.asset(
                icon,
                width: 24,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      desc,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: Theme.of(context).buttonTheme.padding,
              child: CommonArrow(),
            )
          ],
        ),
      ),
    );
  }
}
