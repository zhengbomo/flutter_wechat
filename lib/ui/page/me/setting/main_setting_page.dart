import 'package:flutter/material.dart';
import 'package:flutterwechat/ui/components/navigator_service.dart';
import 'package:flutterwechat/ui/components/normal_button_cell.dart';
import 'package:flutterwechat/ui/components/normal_cell.dart';
import 'package:flutterwechat/ui/components/section_list_view.dart';
import 'package:flutterwechat/ui/page/me/setting/account_setting_page.dart';
import 'package:flutterwechat/ui/page/me/setting/message_setting_page.dart';
import 'package:flutterwechat/ui/view/bm_appbar.dart';

class MainSetting extends StatefulWidget {
  @override
  _MainSettingState createState() => _MainSettingState();
}

class _MainSettingState extends State<MainSetting> {
  var _items = List<List<dynamic>>();

  _setupItem() {
    _items.clear();
    _items.add([
      NormalCellInfo(
        hideSeperator: true,
        title: "账号与安全",
        onPressed: () {
          NavigatorService.push(AccountSettingPage());
        },
      ),
    ]);

    _items.add([
      NormalCellInfo(
        title: "新消息通知",
        onPressed: () {
          NavigatorService.push(MessageSettingPage());
        },
      ),
      NormalCellInfo(
        title: "隐私",
        onPressed: () {},
      ),
      NormalCellInfo(
        hideSeperator: true,
        title: "通用",
        onPressed: () {},
      ),
    ]);

    _items.add([
      NormalCellInfo(
        title: "帮助与反馈",
        onPressed: () {},
      ),
      NormalCellInfo(
        title: "关于微信",
        onPressed: () {},
      ),
      NormalCellInfo(
        hideSeperator: true,
        title: "插件",
        trailing: Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text("版本7.0.13",
              style: TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.w400)),
        ),
        onPressed: () {},
      ),
    ]);

    _items.add([
      NormalButtonInfo(
        "切换帐号",
        onPressed: () {},
      ),
    ]);
    _items.add([
      NormalButtonInfo(
        "退出登录",
        onPressed: () {},
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _setupItem();
    return Scaffold(
      appBar: BMAppBar(
        title: Text("设置"),
      ),
      body: Container(
        child: NotificationListener<ScrollNotification>(
          child: SectionListView(
            numberOfSection: () => _items.length,
            numberOfRowsInSection: (section) => _items[section].length,
            rowWidget: (context, section, row) {
              dynamic cellInfo = _items[section][row];
              if (cellInfo is NormalCellInfo) {
                return NormalCell(cellInfo: cellInfo);
              } else if (cellInfo is NormalButtonInfo) {
                return NormalButtonCell(info: cellInfo);
              } else {
                assert(false);
                return SizedBox(height: 0, width: 0);
              }
            },
            ignoreFirstSectionHeader: true,
          ),
        ),
      ),
    );
  }
}
