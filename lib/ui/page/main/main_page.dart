import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterwechat/data/providers/main_badge_model.dart';
import 'package:flutterwechat/ui/page/chats/main_chat_page.dart';
import 'package:flutterwechat/ui/page/contacts/contacts_page.dart';
import 'package:flutterwechat/ui/page/discover/discovery_page.dart';
import 'package:flutterwechat/ui/page/main/main_tab_bar.dart';
import 'package:flutterwechat/ui/page/me/me_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController;

  final _tabWidget = [MainChatPage(), ContactsPage(), DiscoverPage(), MePage()];

  void initState() {
    super.initState();

    var index = context.read<MainBadgeModel>().selectedIndex;
    this._pageController = PageController(initialPage: index, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MainTabBar(),
      body: Selector(
        builder: (context, int index, child) {
          if (_pageController.hasClients) {
            _pageController.jumpToPage(index);
          }
          return child;
        },
        selector: (context, MainBadgeModel model) {
          return model.selectedIndex;
        },
        child: PageView(
          children: this._tabWidget,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(), // 禁止滑动
        ),
      ),
    );
  }
}

class MyPageView extends PageView {
  set currentPage(int page) {
    this.controller.animateToPage(page, duration: null, curve: null);
  }

  int get currentPage {
    return this.controller.page.round();
  }
}
