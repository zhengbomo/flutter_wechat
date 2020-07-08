import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/components/avatar.dart';
import 'package:flutterwechat/ui/components/navigator_service.dart';
import 'package:flutterwechat/ui/components/normal_cell.dart';
import 'package:flutterwechat/ui/components/normal_section.dart';
import 'package:flutterwechat/ui/components/section_list_view.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';
import 'package:flutterwechat/ui/page/discover/moment_list_page.dart';
import 'package:flutterwechat/ui/page/test_page.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage();
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends AutoKeepAliveState<DiscoverPage> {
  var _items = List<List<NormalCellInfo>>();

  _setupItem() {
    _items.clear();
    _items.add([
      NormalCellInfo(
        title: "朋友圈",
        icon: SvgPicture.asset(
          Constant.assetsImagesDiscover
              .named("icons_outlined_colorful_moment.svg"),
          width: Constant.normalCellIconSize,
        ),
        trailing: Container(
          // color: Colors.red,
          margin: EdgeInsets.only(right: 12),
          width: 30,
          height: 30,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Avatar(
                borderRadius: 3,
                color: Colors.red,
                size: 40,
              ),
              Positioned(
                right: -3,
                top: -3,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.blue,
                ),
              )
            ],
          ),
        ),
        onPressed: () {
          final page = MomentListPage();
          NavigatorService.push(page);
        },
      ),
    ]);

    _items.add([
      NormalCellInfo(
        title: "扫一扫",
        icon: SvgPicture.asset(
          Constant.assetsImagesDiscover.named("icons_outlined_scan.svg"),
          color: Color(0xFF3d83e6),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {
          NavigatorService.push(TestPage());
        },
      ),
      NormalCellInfo(
        title: "摇一摇",
        icon: SvgPicture.asset(
          Constant.assetsImagesDiscover.named("icons_outlined_shake.svg"),
          color: Color(0xFF3d83e6),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {},
      )
    ]);

    _items.add([
      NormalCellInfo(
        title: "看一看",
        icon: SvgPicture.asset(
          Constant.assetsImagesDiscover.named("icons_outlined_news.svg"),
          color: Color(0xFFF6C543),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {},
      ),
      NormalCellInfo(
        title: "搜一搜",
        icon: SvgPicture.asset(
          Constant.assetsImagesDiscover.named("icons_outlined_searchlogo.svg"),
          color: Color(0xfff94747),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {},
      ),
    ]);

    _items.add([
      NormalCellInfo(
        title: "附近的人",
        icon: SvgPicture.asset(
          Constant.assetsImagesDiscover.named("icons_outlined_nearby.svg"),
          color: Color(0xFF3d83e6),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {},
      ),
    ]);

    _items.add([
      NormalCellInfo(
        title: "购物",
        icon: SvgPicture.asset(
          Constant.assetsImagesDiscover.named("icons_outlined_shop.svg"),
          color: Color(0xFFE75E58),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {},
      ),
      NormalCellInfo(
        title: "游戏",
        icon: SvgPicture.asset(
          Constant.assetsImagesDiscover
              .named("icons_outlined_colorful_game.svg"),
          // color: Color(0xFF3d83e6),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {},
      ),
    ]);

    _items.add([
      NormalCellInfo(
        title: "小程序",
        icon: SvgPicture.asset(
          Constant.assetsImagesDiscover.named("icons_outlined_miniprogram.svg"),
          color: Color(0xFF6467e8),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {},
      ),
    ]);
  }

  @override
  void initState() {
    _setupItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: Text("发现"),
      ),
      body: Container(
        child: SectionListView(
          numberOfSection: () => _items.length,
          numberOfRowsInSection: (section) => _items[section].length,
          rowWidget: (context, section, row) {
            NormalCellInfo cellInfo = _items[section][row];
            return NormalCell(cellInfo: cellInfo);
          },
          sectionWidget: (context, section) {
            if (section == 0) {
              return null;
            } else {
              return NormlSection();
            }
          },
        ),
      ),
    );
  }
}
