import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/data/models/chat_section_info.dart';
import 'package:flutterwechat/data/providers/main_badge_model.dart';
import 'package:flutterwechat/ui/view/animted_scale.dart';
import 'package:flutterwechat/ui/view/search_bar.dart';
import 'package:flutterwechat/utils/build_context_read.dart';
import 'package:flutterwechat/data/providers/list_search_bar_model.dart';
import 'package:flutterwechat/data/providers/main_chat_model.dart';
import 'package:flutterwechat/ui/components/add_menu.dart';
import 'package:flutterwechat/ui/components/avatar.dart';
import 'package:flutterwechat/ui/components/child_builder.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';
import 'package:flutterwechat/ui/page/chats/chat_detail_page.dart';
import 'package:flutterwechat/ui/page/main/search_panel.dart';
import 'package:provider/provider.dart';

class MainChatPage extends StatefulWidget {
  @override
  _MainChatPageState createState() => _MainChatPageState();
}

class _MainChatPageState extends AutoKeepAliveState<MainChatPage>
    with SingleTickerProviderStateMixin {
  MainChatModel _mainChatModel;
  ListSearchBarModel _listSearchBarModel = ListSearchBarModel();

  ScrollController _scrollController = ScrollController();

  bool _isDraging = false;

  Offset beginPosition;
  Offset endPosition;

  @override
  void initState() {
    _mainChatModel = MainChatModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final query = context.getInheritedWidget<MediaQuery>().data;
    super.build(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _mainChatModel),
        ChangeNotifierProvider.value(value: _listSearchBarModel),
      ],
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ChildBuilder6(
            // AppBar
            child1: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text("微信"),
              actions: [
                IconButton(
                  icon: SvgPicture.asset(
                    Constant.assetsImagesChat.named("icons_outlined_add2.svg"),
                    color: Color(0xFF181818),
                  ),
                  onPressed: () {
                    _mainChatModel.setShowMenu(true);
                  },
                )
              ],
            ),
            // Add Menu
            child2: Selector(
              builder: (context, show, child) {
                return AddMenu(
                  show: show,
                  dismissCall: () {
                    context.read<MainChatModel>().setShowMenu(false);
                  },
                );
              },
              selector: (context, MainChatModel model) => model.showMenu,
            ),
            // Search Panel
            child3: SearchPanel(),
            // SerchBar
            child4: SizedBox(
              height: Constant.searchBarHeight,
              child: SearchBar(beginEdit: () {
                _listSearchBarModel.changeFocus(true);
                // 隐藏tabbar
                context.read<MainBadgeModel>().showBottomTabBar(false);
              }, cancelCallback: () {
                _listSearchBarModel.changeFocus(false);
                // 显示tabbar
                context.read<MainBadgeModel>().showBottomTabBar(true);
              }),
            ),
            // Content
            child5: Container(
              color: Colors.white,
              child: Scrollbar(
                child: Builder(builder: (context) {
                  bool openTopView = false;
                  bool isDrag = false;
                  context.select((MainChatModel model) => model.changeId);
                  return NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification) {
                        if (isDrag) {
                          if (openTopView) {
                            return false;
                          }

                          final offset = notification.metrics.pixels;

                          _isDraging = notification.dragDetails != null;

                          if (!_isDraging && offset < -150) {
                            // 放手，打开topView
                            openTopView = true;
                          }

                          final model = _listSearchBarModel;
                          if (openTopView) {
                            // 打开topView
                            model.appbarDuration = Constant.kCommonDuration;
                            _mainChatModel.topViewDuration =
                                Constant.kCommonDuration;
                            _mainChatModel.appletViewDuration =
                                Constant.kCommonDuration;

                            final screenHeight =
                                query.size.height - query.padding.top;
                            model.appbarOffset = screenHeight -
                                kToolbarHeight -
                                query.padding.top;
                            model.listViewOffset = screenHeight -
                                kToolbarHeight -
                                query.padding.top;
                            _mainChatModel.topViewShowOffset =
                                model.listViewOffset;
                            // 隐藏tabbar
                            context
                                .read<MainBadgeModel>()
                                .showBottomTabBar(false);

                            _mainChatModel.appletViewAlpha = 1;
                            _mainChatModel.appletScale = 1;
                          } else {
                            model.appbarOffset = max(0, -offset);
                            _mainChatModel.topViewShowOffset = -offset;

                            if (offset < -100) {
                              // 开始缩放
                              final span = -offset - 100;
                              double addition = span / 500;
                              addition = min(1, addition);
                              _mainChatModel.appletViewAlpha = addition * 1;
                              _mainChatModel.appletScale = 0.5 + addition * 0.5;
                            } else {
                              _mainChatModel.appletViewAlpha = 0;
                              _mainChatModel.appletScale = 0.5;
                            }
                          }
                        }
                      } else if (notification is ScrollEndNotification) {
                        if (isDrag) {
                          final model = _listSearchBarModel;

                          if (!openTopView) {
                            model.appbarDuration = Constant.kCommonDuration;

                            print("ddd");
                            model.appbarOffset = 0;
                            model.listViewOffset = 0;

                            _mainChatModel.topViewDuration =
                                Constant.kCommonDuration;
                            _mainChatModel.topViewShowOffset = 0;
                          }
                          openTopView = false;
                          isDrag = false;
                        }
                        _isDraging = false;
                      } else if (notification is ScrollStartNotification) {
                        isDrag = notification.dragDetails != null;
                        _isDraging = isDrag;
                        if (isDrag) {
                          final model = _listSearchBarModel;
                          model.appbarDuration = Duration.zero;
                          _mainChatModel.topViewDuration = Duration.zero;

                          _mainChatModel.appletViewDuration = Duration.zero;
                          _mainChatModel.topViewTop = 0;
                        }
                      }
                      return false;
                    },
                    child: PrimaryScrollController(
                      controller: _scrollController,
                      child: ListView.separated(
                        itemBuilder: (c, i) {
                          if (i == 0) {
                            return SizedBox(
                              height: Constant.searchBarHeight,
                              child: SearchBar(beginEdit: () {
                                _listSearchBarModel.changeFocus(true);
                                // 隐藏tabbar
                                context
                                    .read<MainBadgeModel>()
                                    .showBottomTabBar(false);
                              }, cancelCallback: () {
                                _listSearchBarModel.changeFocus(false);
                                // 显示tabbar
                                context
                                    .read<MainBadgeModel>()
                                    .showBottomTabBar(true);
                              }),
                            );
                          } else {
                            return _createItem(
                                c, _mainChatModel.sections[i - 1]);
                          }
                        },
                        separatorBuilder: (c, i) {
                          if (i == 0) {
                            return SizedBox();
                          } else {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                              child: Divider(height: 1, color: Colors.black12),
                            );
                          }
                        },
                        itemCount: _mainChatModel.sections.length,
                      ),
                    ),
                  );
                }),
              ),
            ),
            // top view
            child6: Offstage(
              offstage: false,
              child: Builder(builder: (context) {
                return Stack(
                  fit: StackFit.expand,
                  overflow: Overflow.clip,
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      right: 0,
                      top: context
                          .select((MainChatModel model) => model.appletViewTop),
                      height: query.size.height + query.padding.top,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Style.primaryColor,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: query.padding.top),
                              child: Builder(
                                builder: (context) {
                                  final scale = context.select(
                                      (MainChatModel model) =>
                                          model.appletScale);

                                  return AnimatedScale(
                                    duration: _mainChatModel.appletViewDuration,
                                    curve: Curves.easeInOut,
                                    scale: scale,
                                    child: AnimatedOpacity(
                                      opacity: _mainChatModel.appletViewAlpha,
                                      curve: Curves.easeInOut,
                                      duration:
                                          _mainChatModel.appletViewDuration,
                                      child: Column(
                                        children: <Widget>[
                                          AppBar(
                                            title: Text("小程序"),
                                          ),
                                          Container(
                                            color: Colors.cyan,
                                            height: 400,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: Builder(builder: (context) {
                                return GestureDetector(
                                  onPanStart: (data) {
                                    beginPosition = data.localPosition;
                                    _mainChatModel.topViewDuration =
                                        Duration.zero;
                                    _listSearchBarModel.appbarDuration =
                                        Duration.zero;
                                    _mainChatModel.topViewTop = 0;
                                    print("start");
                                  },
                                  onPanUpdate: (data) {
                                    endPosition = data.localPosition;
                                    var offset =
                                        endPosition.dy - beginPosition.dy;
                                    final screenHeight = query.size.height;

                                    offset = min(0, offset);

                                    _mainChatModel.topViewTop = offset;

                                    _listSearchBarModel.appbarOffset =
                                        screenHeight -
                                            kToolbarHeight -
                                            query.padding.top * 2 +
                                            offset;
                                    _listSearchBarModel.listViewOffset =
                                        _listSearchBarModel.appbarOffset;

                                    _mainChatModel.appletViewAlpha =
                                        (1 - min(1, (-offset / 700)));
                                  },
                                  onPanEnd: (data) {
                                    final screenHeight = query.size.height;
                                    _mainChatModel.topViewDuration =
                                        Constant.kCommonDuration;
                                    _listSearchBarModel.appbarDuration =
                                        Constant.kCommonDuration;

                                    _mainChatModel.topViewTop = -(screenHeight -
                                        kToolbarHeight -
                                        query.padding.top * 2);
                                    _listSearchBarModel.appbarOffset = 0;
                                    _listSearchBarModel.listViewOffset = 0;
                                    _mainChatModel.topViewShowOffset = 0;
                                    _mainChatModel.appletViewAlpha = 0;
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            // builder
            builder: (context, appbar, addMenu, searchPanel, searchBar, content,
                topView) {
              final model = context.watch<ListSearchBarModel>();

              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  // 内容
                  AnimatedPositioned(
                    curve: Curves.easeInOut,
                    duration: _listSearchBarModel.appbarDuration,
                    top: query.padding.top +
                        kToolbarHeight +
                        (model.isFocus
                            ? -kToolbarHeight
                            : context.select((ListSearchBarModel model) =>
                                model.listViewOffset)),
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: content,
                  ),
                  // appbar
                  AnimatedPositioned(
                    curve: Curves.easeInOut,
                    duration: context.select(
                        (ListSearchBarModel model) => model.appbarDuration),
                    top: query.padding.top +
                        (model.isFocus
                            ? (-kToolbarHeight - query.padding.top)
                            : context.select((ListSearchBarModel model) =>
                                model.appbarOffset)),
                    left: 0,
                    right: 0,
                    height: kToolbarHeight,
                    child: appbar,
                  ),
                  // mask view
                  AnimatedPositioned(
                    curve: Curves.easeInOut,
                    duration: context.select(
                        (ListSearchBarModel model) => model.appbarDuration),
                    left: 0,
                    right: 0,
                    top: query.padding.top +
                        (model.isFocus
                            ? (-kToolbarHeight - query.padding.top)
                            : context.select((ListSearchBarModel model) =>
                                model.appbarOffset)),
                    // height: kToolbarHeight,
                    bottom: 0,
                    child: IgnorePointer(
                      ignoring: _mainChatModel.appletViewAlpha < 0.9,
                      child: Container(
                          color: Style.primaryColor.withAlpha(context.select(
                              (MainChatModel model) =>
                                  (model.appletViewAlpha * 100).toInt()))),
                    ),
                  ),
                  // search panel
                  AnimatedPositioned(
                    curve: Curves.easeInOut,
                    duration: Constant.kCommonDuration,
                    top: query.padding.top +
                        (model.isFocus ? -kToolbarHeight : 0) +
                        kToolbarHeight +
                        Constant.searchBarHeight,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Offstage(
                      offstage: !model.isFocus,
                      child: searchPanel,
                    ),
                  ),
                  // AddMenu
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: addMenu,
                  ),
                  // top panel
                  AnimatedPositioned(
                    curve: Curves.easeInOut,
                    left: 0,
                    right: 0,
                    top: context
                        .select((MainChatModel model) => model.topViewTop),
                    height: query.padding.top +
                        context.select(
                            (MainChatModel model) => model.topViewShowOffset),
                    duration: _mainChatModel.topViewDuration,
                    child: topView,
                  ),
                ],
              );
            },
          ),
        ),
      ),
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
        ),
      );
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
                  Avatar(
                    color: info.avatar,
                    size: 50,
                    borderRadius: 6,
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
