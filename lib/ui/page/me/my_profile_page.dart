import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/components/avatar.dart';
import 'package:flutterwechat/ui/components/navigator_service.dart';
import 'package:flutterwechat/ui/components/normal_cell.dart';
import 'package:flutterwechat/ui/components/section_list_view.dart';
import 'package:flutterwechat/ui/page/me/my_qrcode_page.dart';
import 'package:flutterwechat/ui/view/bm_appbar.dart';

class MyProfilePage extends StatelessWidget {
  final _items = [
    [
      NormalCellInfo(
        hideSeperator: false,
        title: "头像",
        trailing: Padding(
          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Avatar(
            color: Colors.red,
            size: 40,
          ),
        ),
        onPressed: () {},
      ),
      NormalCellInfo(
        hideSeperator: false,
        title: "名字",
        trailing: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text("八戒"),
        ),
        onPressed: () {},
      ),
      NormalCellInfo(
        hideSeperator: false,
        title: "微信号",
        trailing: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text("bomo00"),
        ),
        onPressed: () {},
      ),
      NormalCellInfo(
        hideSeperator: false,
        title: "我的二维码",
        trailing: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: SvgPicture.asset(
            Constant.assetsImagesMe.named("icons_outlined_qr_code.svg"),
            width: 25,
            color: Colors.black54,
          ),
        ),
        onPressed: () {
          NavigatorService.push(MyQrcodePage());
        },
      ),
      NormalCellInfo(
        hideSeperator: true,
        title: "更多",
        onPressed: () {},
      ),
    ],
    [
      NormalCellInfo(
        hideSeperator: true,
        title: "我的地址",
        onPressed: () {},
      ),
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMAppBar(
        elevation: 0,
        title: Text("个人信息"),
      ),
      body: SectionListView(
        numberOfSection: () => _items.length,
        numberOfRowsInSection: (section) => _items[section].length,
        ignoreFirstSectionHeader: true,
        rowWidget: (c, section, row) {
          dynamic cellInfo = _items[section][row];
          if (cellInfo is NormalCellInfo) {
            return NormalCell(
              cellInfo: cellInfo,
              dividerIndent: 12,
            );
          } else {
            assert(false);
            return SizedBox(height: 0, width: 0);
          }
        },
      ),
    );
  }
}
