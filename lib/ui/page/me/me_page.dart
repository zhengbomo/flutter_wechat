import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/providers/main_badge_model.dart';
import 'package:flutterwechat/ui/components/navigator_service.dart';
import 'package:flutterwechat/ui/page/me/my_profile_page.dart';
import 'package:flutterwechat/ui/page/me/setting/main_setting_page.dart';
import 'package:flutterwechat/ui/page/me/take_video_moment.dart';
import 'package:provider/provider.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/components/avatar.dart';
import 'package:flutterwechat/ui/components/common_arrow.dart';
import 'package:flutterwechat/ui/components/normal_cell.dart';
import 'package:flutterwechat/ui/components/normal_section.dart';
import 'package:flutterwechat/ui/components/section_list_view.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends AutoKeepAliveState<MePage> {
  var _items = List<List<NormalCellInfo>>();

  bool _isAnimating = false;
  bool _isShow = false;
  bool _panning = false;
  bool _isDraging = false;

  Widget _header;

  _setupItem() {
    _items.clear();
    _items.add([
      NormalCellInfo(
        hideSeperator: true,
        title: "支付",
        icon: SvgPicture.asset(
          Constant.assetsImagesMe.named("icons_outlined_wechatpay.svg"),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {},
      ),
    ]);

    _items.add([
      NormalCellInfo(
        title: "收藏",
        icon: SvgPicture.asset(
          Constant.assetsImagesMe
              .named("icons_outlined_colorful_favorites.svg"),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {},
      ),
      NormalCellInfo(
        title: "相册",
        icon: SvgPicture.asset(
          Constant.assetsImagesMe.named("icons_outlined_album.svg"),
          color: Color(0xFF3d83e6),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {},
      ),
      NormalCellInfo(
        title: "卡包",
        icon: SvgPicture.asset(
          Constant.assetsImagesMe.named("icons_outlined_colorful_cards.svg"),
          color: Color(0xFF3d83e6),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {},
      ),
      NormalCellInfo(
        hideSeperator: true,
        title: "表情",
        icon: SvgPicture.asset(
          Constant.assetsImagesMe.named("icons_outlined_sticker.svg"),
          color: Color(0xFFEDA150),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {},
      ),
    ]);

    _items.add([
      NormalCellInfo(
        hideSeperator: true,
        title: "设置",
        icon: SvgPicture.asset(
          Constant.assetsImagesMe.named("icons_outlined_setting.svg"),
          color: Color(0xFF3d83e6),
          width: Constant.normalCellIconSize,
        ),
        onPressed: () {
          NavigatorService.push(MainSetting());
        },
      ),
    ]);
  }

  @override
  void initState() {
    super.initState();
  }

  double _offset = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _header = _createHeader();

    _setupItem();

    final int millsecond = 250;

    final query = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 列表
          AnimatedPositioned(
            left: 0,
            right: 0,
            top: (_isAnimating || _panning) ? _offset : 0,
            bottom: 0,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: _isAnimating ? millsecond : 0),
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (_isAnimating) {
                  return false;
                }
                if (_isShow) {
                  return false;
                }

                if (notification is ScrollStartNotification) {
                  _isDraging = notification.dragDetails != null;
                }
                final offset = notification.metrics.pixels -
                    notification.metrics.maxScrollExtent;
                print(offset);
                if (offset <= 0) {
                  setState(() {
                    _offset = -offset;
                  });
                }
                if (notification is ScrollUpdateNotification) {
                  if (notification.dragDetails == null) {
                    _isDraging = false;

                    // 释放
                    if (offset < -150) {
                      // 下拉
                      print("下拉");
                      _showPai(context);
                    }
                  }
                } else if (notification is ScrollEndNotification) {
                  if (_isDraging) {
                    _isDraging = false;
                  }
                }
                return false;
              },
              child: ScrollConfiguration(
                behavior: Constant.sameScrollBehavior,
                child: SectionListView(
                  header: _header,
                  numberOfSection: () => _items.length,
                  numberOfRowsInSection: (section) => _items[section].length,
                  rowWidget: (context, section, row) {
                    NormalCellInfo cellInfo = _items[section][row];
                    return NormalCell(cellInfo: cellInfo);
                  },
                  sectionWidget: (context, section) {
                    return NormlSection();
                  },
                ),
              ),
            ),
          ),
          // AppBar
          AnimatedPositioned(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: _isAnimating ? millsecond : 0),
            left: 0,
            right: 0,
            top: _isAnimating ? _offset : 0,
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              // title: Text("我"),
              actions: <Widget>[
                IconButton(
                  icon: SvgPicture.asset(
                    Constant.assetsImagesMe.named("icons_filled_camera.svg"),
                    width: Constant.normalCellIconSize,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          // VideoMoment
          AnimatedPositioned(
            curve: Curves.easeInOut,
            onEnd: () {
              if (_isAnimating) {
                _isAnimating = false;
              }
            },
            duration: Duration(milliseconds: _isAnimating ? millsecond : 0),
            left: 0,
            right: 0,
            top: -query.size.height + query.padding.top + _offset,
            height: query.size.height,
            child: TakeVideoMoment(
              panStart: (data) {
                _panning = true;
              },
              panUpdate: (position, deltaOffset) {
                setState(() {
                  _offset = query.size.height -
                      query.padding.top +
                      min(0, deltaOffset.dy);
                });
                print(deltaOffset.dy);
              },
              panEnd: (data) {
                _panning = false;
                if (data != null) {
                  if (data.dy < -150) {
                    _hidePai(context);
                  } else {
                    _showPai(context);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _showPai(BuildContext context) {
    final query = MediaQuery.of(context);
    context.read<MainBadgeModel>().showBottomTabBar(false);
    _isAnimating = true;
    _isShow = true;
    setState(() {
      _offset = query.size.height - query.padding.top;
    });
  }

  _hidePai(BuildContext context) {
    context.read<MainBadgeModel>().showBottomTabBar(true);
    _isAnimating = true;
    _isShow = false;
    setState(() {
      _offset = 0;
    });
  }

  Widget _createHeader() {
    return GestureDetector(
      onTap: () {
        NavigatorService.push(MyProfilePage());
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, kToolbarHeight + 20, 20, 20),
        height: 170,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Avatar(
              userInteractionEnable: false,
              color: Colors.blueAccent,
              borderRadius: 6,
              size: 56,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "八戒",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "微信号: bomo00",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: SvgPicture.asset(
                              Constant.assetsImagesMe
                                  .named("icons_outlined_qr_code.svg"),
                              width: 18,
                              color: Colors.black54,
                            ),
                          ),
                          CommonArrow(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
