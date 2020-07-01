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
//    Selector(
//        builder: (BuildContext context, int data, Widget child) {
//          print('Text 1 重绘了。。。。。。。。。。');
//          return Text(
//            //获取数据
//              'Text1 : ${data.toString()}',
//              style: TextStyle(fontSize: 20));
//        }, selector:
//        (BuildContext context, CounterProvider counterProvider) {
//      //这个地方返回具体的值，对应builder中的data
//      return counterProvider.value;
//    })

    // Provider.of(context)
    // context.select((MainBadgeModel m) => m.selectedIndex)

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
              // onPageChanged: _onPageChanged,
              physics: NeverScrollableScrollPhysics(), // 禁止滑动
            )));
  }
}

class MyPageView extends PageView {
  set currentPage(int page) {
    this.controller.animateToPage(page, duration: null, curve: null);
  }

  // MyPageView({
  //   Key key,
  //   PageController controller,
  //   List<Widget> children = const <Widget>[],
  // }) : super(key: key, );

  int get currentPage {
    return this.controller.page.round();
  }
}
