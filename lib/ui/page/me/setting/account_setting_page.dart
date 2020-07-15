import 'package:flutter/material.dart';
import 'package:flutterwechat/ui/components/normal_cell.dart';
import 'package:flutterwechat/ui/components/normal_label_cell.dart';
import 'package:flutterwechat/ui/components/section_list_view.dart';
import 'package:flutterwechat/ui/view/bm_appbar.dart';

class AccountSettingPage extends StatefulWidget {
  @override
  _AccountSettingPageState createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  var _items = List<List<dynamic>>();

  _setupItem() {
    _items.clear();
    _items.add([
      NormalCellInfo(
        title: "微信号",
        trailing: Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(
            "bomo00",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        onPressed: () {},
      ),
      NormalCellInfo(
        title: "手机号",
        trailing: Padding(
          padding: EdgeInsets.only(right: 12),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.lock,
                  color: Colors.green,
                  size: 18,
                ),
              ),
              Text(
                "18102620462",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        onPressed: () {},
      ),
    ]);

    _items.add([
      NormalCellInfo(
        title: "微信密码",
        trailing: Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text("已设置"),
        ),
        onPressed: () {},
      ),
      NormalCellInfo(
        title: "声音锁",
        trailing: Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text("未设置"),
        ),
        onPressed: () {},
      ),
    ]);

    _items.add([
      NormalCellInfo(
        title: "应急联系人",
        onPressed: () {},
      ),
      NormalCellInfo(
        title: "登录设备管理",
        onPressed: () {},
      ),
      NormalCellInfo(
        title: "更多安全设置",
        onPressed: () {},
      ),
    ]);

    _items.add([
      NormalCellInfo(
        title: "帮助朋友冻结微信",
        onPressed: () {},
      ),
      NormalCellInfo(
        title: "微信安全中心",
        onPressed: () {},
      ),
      "如果遇到账号信息泄露、忘记密码、诈骗等账号安全问题，可前往微信安全中心"
    ]);

    _items.add([
      SizedBox(
        height: 100,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _setupItem();
    return Scaffold(
      appBar: BMAppBar(
        title: Text("账号与安全"),
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
              } else if (cellInfo is String) {
                return NormalLabelCell(cellInfo);
              } else if (cellInfo is Widget) {
                return cellInfo;
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
