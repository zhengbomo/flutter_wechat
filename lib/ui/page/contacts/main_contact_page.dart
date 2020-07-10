import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/components/avatar.dart';
import 'package:flutterwechat/ui/components/search_list_page.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';
import 'package:flutterwechat/ui/page/contacts/index_bar.dart';
import 'package:flutterwechat/ui/page/main/search_panel.dart';
import 'package:flutterwechat/utils/scroll_controller_ext.dart';
import 'package:tuple/tuple.dart';
import 'package:flutterwechat/utils/iterable_ext.dart';

class MainContactPage extends StatefulWidget {
  @override
  _MainContactPageState createState() => _MainContactPageState();
}

class _MainContactPageState extends AutoKeepAliveState<MainContactPage> {
  static const double _itemHeight = 60;
  static const double _headerHeight = 30;

  final _stickyHeaderController = StickyHeaderController();
  ScrollController _scrollController = ScrollController();

  final _topItems = ["新的朋友", "仅聊天的朋友", "群聊", "标签", "公众号", "企业微信联系人"];
  List<Tuple2<String, List<String>>> _contacts =
      List<Tuple2<String, List<String>>>();

  int _index = 0;

  List<String> _keys = List();

  @override
  void initState() {
    _contacts.clear();
    _contacts.add(Tuple2("A", ["阿福", "阿胶", "阿珍"]));
    _contacts.add(Tuple2("B", ["八戒", "Bash", "BIM"]));
    _contacts.add(Tuple2("D", ["大眼猫", "冬瓜"]));
    _contacts.add(Tuple2("X", ["小菜", "小明"]));

    _contacts.add(Tuple2("#", [
      "😇😐😑😶😏😣😥😮😯😪😫😴😌😛😜😝😒😓😔😕😲😷😖😞😟😤😢😭😦😧😨😬😰😱😳😵😡",
      "😀",
      // "😁",
      // "😂",
      // "😃",
      // "😄",
      // "😅",
      // "😆",
      // "😉",
      "😘",
      "😗",
      "😙",
      "😚",
      "☺",
    ]));

    _keys = _contacts.map((e) => e.item1).toList();

    _stickyHeaderController.objectChanged = (index) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _index = index;
        });
      });
    };
    super.initState();
  }

  bool _jumpToSection(int section) {
    final top = Constant.searchBarHeight + _itemHeight * _topItems.length;

    if (section == 0) {
      if (_scrollController.offset != top) {
        _scrollController.jumpTo(top);
      }
    } else {
      var offset = _contacts.getRange(0, section).fold(
          top,
          (previousValue, element) =>
              previousValue +
              element.item2.length * _itemHeight +
              _headerHeight);
      if (_scrollController.offset != offset) {
        _scrollController.safeJumpTo(offset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SearchListPage(
        appbar: AppBar(
          title: Text("通讯录"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            )
          ],
        ),
        builder: (BuildContext context, Widget searchBar) {
          return Stack(
            children: <Widget>[
              DefaultStickyHeaderController(
                controller: _stickyHeaderController,
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    // search bar
                    SliverToBoxAdapter(
                      child: searchBar,
                    ),
                    // top items
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) {
                          return _buildItem(_topItems[i], () {});
                        },
                        childCount: _topItems.length,
                      ),
                    ),
                    // list
                    ..._contacts
                        .mapIndex(
                          (e, i) => SliverStickyHeader(
                            object: i,
                            header: Container(
                              height: 30.0,
                              color: Color(0xffe9e9e9),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          e.item1,
                                          style: const TextStyle(
                                              color: Color(0xff666666)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 0.5,
                                    thickness: 0.5,
                                  ),
                                ],
                              ),
                            ),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, i) {
                                  return _buildItem(e.item2[i], () {});
                                },
                                childCount: e.item2.length,
                              ),
                            ),
                          ),
                        )
                        .toList()
                  ],
                ),
              ),
              Positioned(
                right: 0,
                width: 100,
                top: 0,
                bottom: 0,
                child: IndexBar(
                  index: _index,
                  keys: _keys,
                  indexChanged: (i) {
                    _jumpToSection(i);
                  },
                ),
              )
            ],
          );
        },
        searchPanel: SearchPanel(),
      ),
    );
  }

  Widget _buildItem(String title, VoidCallback onPressed) {
    return Container(
      height: _itemHeight,
      child: FlatButton(
        color: Colors.white,
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(
                  children: <Widget>[
                    Avatar(
                      userInteractionEnable: false,
                      size: 40,
                      borderRadius: 3,
                      color: Colors.blue,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              indent: 68,
              height: 1,
            )
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
