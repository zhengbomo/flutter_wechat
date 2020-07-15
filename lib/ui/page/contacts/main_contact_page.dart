import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/models/contact_info.dart';
import 'package:flutterwechat/ui/components/avatar.dart';
import 'package:flutterwechat/ui/components/navigator_service.dart';
import 'package:flutterwechat/ui/components/search_list_page.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';
import 'package:flutterwechat/ui/page/contacts/add_freiend_page.dart';
import 'package:flutterwechat/ui/page/contacts/index_bar.dart';
import 'package:flutterwechat/ui/page/contacts/user_profile_page.dart';
import 'package:flutterwechat/ui/page/main/search_panel.dart';
import 'package:flutterwechat/utils/scroll_controller_ext.dart';
import 'package:provider/provider.dart';
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

  final _topItems = [
    Tuple2(Constant.assetsImagesContacts.named("plugins_friend_notify.png"),
        "新的朋友"),
    Tuple2(Constant.assetsImagesContacts.named("contact_chatonly_friends.png"),
        "仅聊天的朋友"),
    Tuple2(Constant.assetsImagesContacts.named("add_friend_icon_addgroup.png"),
        "群聊"),
    Tuple2(Constant.assetsImagesContacts.named("contact_icon_contacttag.png"),
        "标签"),
    Tuple2(Constant.assetsImagesContacts.named("add_friend_icon_offical.png"),
        "公众号"),
    Tuple2(
        Constant.assetsImagesContacts
            .named("add_friend_icon_search_wework.png"),
        "企业微信联系人"),
  ];
  final List<Tuple2<String, List<ContactInfo>>> _contacts =
      List<Tuple2<String, List<ContactInfo>>>();

  List<String> _keys = List();

  // 排序用的key
  String _orderKeys = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#";

  final _MainContactModel _model = _MainContactModel(0);

  @override
  void initState() {
    _contacts.clear();

    final allContact = List.generate(20, (index) => ContactInfo.random());
    Map<String, List<ContactInfo>> map = Map();
    for (var contact in allContact) {
      final tagIndex = contact.tagIndex;
      var list = map[tagIndex];
      if (list == null) {
        map[tagIndex] = [contact];
      } else {
        list.add(contact);
      }
    }
    final allKeys = map.keys.toList();
    // 排序key
    allKeys.sort((a, b) {
      return _orderKeys.indexOf(a).compareTo(_orderKeys.indexOf(b));
    });
    for (var i in allKeys) {
      final list = map[i];
      _contacts.add(Tuple2(i, list));
    }

    _keys = _contacts.map((e) => e.item1).toList();

    _stickyHeaderController.objectChanged = (index) {
      print("header changed $index");
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (index == -1) {
          _model.index = index;
        } else {
          _model.index = index;
        }
      });
    };
    super.initState();
  }

  void _jumpToSection(int section) {
    final top = Constant.searchBarHeight + _itemHeight * _topItems.length;

    if (section == 0) {
      if (_scrollController.offset != top) {
        _scrollController.jumpTo(top + 0.1);
      }
    } else {
      var offset = _contacts.getRange(0, section).fold(
              top,
              (previousValue, element) =>
                  previousValue +
                  element.item2.length * _itemHeight +
                  _headerHeight) +
          0.1;
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
          centerTitle: true,
          title: Text("通讯录"),
          actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset(Constant.assetsImagesContacts
                  .named("icons_outlined_add_friends.svg")),
              onPressed: () {
                NavigatorService.push(AddFriendPage());
              },
            )
          ],
        ),
        builder: (BuildContext context, Widget searchBar) {
          print("build content");
          return Stack(
            children: <Widget>[
              DefaultStickyHeaderController(
                controller: _stickyHeaderController,
                child: PrimaryScrollController(
                  controller: _scrollController,
                  child: CustomScrollView(
                    primary: true,
                    slivers: <Widget>[
                      // search bar
                      SliverToBoxAdapter(
                        child: searchBar,
                      ),
                      // top items
                      SliverStickyHeader(
                        object: 0,
                        header: SizedBox(
                          height: 0.1,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, i) {
                              final avatar = Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image: AssetImage(_topItems[i].item1),
                                  ),
                                ),
                              );
                              return _buildItem(
                                  _topItems[i].item2, avatar, () {});
                            },
                            childCount: _topItems.length,
                          ),
                        ),
                      ),
                      // list
                      ..._contacts
                          .mapIndex(
                            (e, i) => SliverStickyHeader(
                              object: i + 1,
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
                                    final avatar = Avatar(
                                      userInteractionEnable: false,
                                      size: 40,
                                      borderRadius: 3,
                                      color: e.item2[i].avatar,
                                    );
                                    return _buildItem(
                                      e.item2[i].name,
                                      avatar,
                                      () {
                                        NavigatorService.push(
                                            UserProfilePage());
                                      },
                                    );
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
              ),
              Positioned(
                right: 0,
                width: 100,
                top: 0,
                bottom: 0,
                child: ChangeNotifierProvider.value(
                  value: _model,
                  child: Builder(
                    builder: (context) {
                      final model = context.watch<_MainContactModel>();
                      return IndexBar(
                        panRelease: () {
                          _model.index = _stickyHeaderController.object;
                        },
                        itemCount: _keys.length + 1,
                        builder: (context, i, selected) {
                          bool isSearch = i == 0;
                          return Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                            decoration: BoxDecoration(
                              color:
                                  (!isSearch && selected) ? Colors.green : null,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: _itemHeight,
                            height: _itemHeight,
                            alignment: Alignment.center,
                            child: isSearch
                                ? Icon(
                                    Icons.search,
                                    size: 15,
                                    color: Colors.black87,
                                  )
                                : Text(
                                    "${_keys[i - 1]}",
                                    style: TextStyle(
                                      color: selected
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                          );
                        },
                        index: model.index,
                        indexChanged: (i) {
                          if (i == 0) {
                            _scrollController.jumpTo(0);
                          } else {
                            _jumpToSection(i - 1);
                          }
                          _model.index = i;
                        },
                        bubbleWidgetBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return null;
                          } else {
                            return Text(
                              _keys[index - 1],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
        searchPanel: SearchPanel(),
      ),
    );
  }

  Widget _buildItem(String title, Widget avatar, VoidCallback onPressed) {
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
                    avatar,
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
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

class _MainContactModel extends ChangeNotifier {
  _MainContactModel(int index) : _index = index;

  int _index;

  int get index => _index;

  set index(int index) {
    if (_index != index) {
      _index = index;
      notifyListeners();
    }
  }
}
