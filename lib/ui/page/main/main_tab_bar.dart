import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/constants/shares.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/data/providers/main_badge_model.dart';
import 'package:flutterwechat/ui/page/main/tabbar_item.dart';
import 'package:flutterwechat/ui/view/badge_icon.dart';
import 'package:provider/provider.dart';
import 'package:quiver/iterables.dart';

class MainTabBar extends StatelessWidget {
  final _tabs = [
    TabBarItem(
        "微信",
        Constant.assetsImagesTabbar.named("icons_filled_chats.svg"),
        Constant.assetsImagesTabbar.named("icons_outlined_chats.svg")),
    TabBarItem(
        "通讯录",
        Constant.assetsImagesTabbar.named("icons_filled_contacts.svg"),
        Constant.assetsImagesTabbar.named("icons_outlined_contacts.svg")),
    TabBarItem(
        "发现",
        Constant.assetsImagesTabbar.named("icons_filled_discover.svg"),
        Constant.assetsImagesTabbar.named("icons_outlined_discover.svg")),
    TabBarItem("我", Constant.assetsImagesTabbar.named("icons_filled_me.svg"),
        Constant.assetsImagesTabbar.named("icons_outlined_me.svg")),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        // 去掉水波纹效果
        splashFactory: Shares.noInkFeatureFactory,
        // 去掉点击效果
        highlightColor: Colors.transparent,
      ),
      child: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 250),
          height: context.select((MainBadgeModel m) => m.isShowBottomTabBar)
              ? Constant.bootomNavigationBarHeight +
                  MediaQuery.of(context).padding.bottom
              : 0.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: BottomNavigationBar(
                  items: _createBottomItems(_tabs, context),
                  currentIndex:
                      context.select((MainBadgeModel m) => m.selectedIndex),
                  onTap: (index) {
                    context.read<MainBadgeModel>().setSelectedIndex(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  selectedFontSize: 14,
                  unselectedFontSize: 14,
                  iconSize: Constant.tabBarIconSize,
                  selectedItemColor: Style.bottomTabbarTintColor,
                  unselectedItemColor: Color(0xFF181818),
                ),
              ),
            ],
            // maxHeight: 60.0 + MediaQuery.of(context).padding.bottom,
          )),
    );
  }

  // 创建底部导航item
  List<BottomNavigationBarItem> _createBottomItems(
      List<TabBarItem> tabBars, BuildContext context) {
    var model = Provider.of<MainBadgeModel>(context);
    var badges = [
      model.messageBadge,
      model.contactBadge,
      model.discoveryBadge,
      model.meBadge,
    ];

    return zip([tabBars, badges]).map((i) {
      TabBarItem tabBar = i[0];
      String badge = i[1];
      return BottomNavigationBarItem(
        icon: BadgeIcon(
          title: badge,
          icon: SvgPicture.asset(tabBar.image),
        ),
        activeIcon: BadgeIcon(
          title: badge,
          icon: SvgPicture.asset(tabBar.selectedImage,
              color: Style.bottomTabbarTintColor),
        ),
        title: Text(
          tabBar.title,
          textScaleFactor: 1.0,
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
      );
    }).toList();
  }
}
