import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/providers/list_search_bar_model.dart';
import 'package:flutterwechat/data/providers/main_badge_model.dart';
import 'package:flutterwechat/ui/view/search_bar.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

typedef WidgetBuilder1<T> = Widget Function(BuildContext context, T searchBar);

class SearchListPage extends StatelessWidget {
  final Widget appbar;
  final Widget searchPanel;
  final WidgetBuilder1<Widget> builder;
  final Widget child;

  SearchListPage({
    @required this.appbar,
    this.child,
    @required this.searchPanel,
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListSearchBarModel(),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: _SearchListContent(
          appbar: this.appbar,
          searchPanel: this.searchPanel,
          child: this.builder(
            context,
            Builder(builder: (context) {
              return SizedBox(
                height: Constant.searchBarHeight,
                child: SearchBar(beginEdit: () {
                  context.read<ListSearchBarModel>().changeFocus(true);
                  // 隐藏tabbar
                  context.read<MainBadgeModel>().showBottomTabBar(false);
                }, cancelCallback: () {
                  context.read<ListSearchBarModel>().changeFocus(false);
                  // 显示tabbar
                  context.read<MainBadgeModel>().showBottomTabBar(true);
                }),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _SearchListContent extends StatefulWidget {
  final Widget appbar;
  final Widget searchPanel;
  final Widget child;

  _SearchListContent(
      {@required this.appbar,
      @required this.searchPanel,
      @required this.child});

  @override
  _SearchListContentState createState() => _SearchListContentState();
}

class _SearchListContentState extends State<_SearchListContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListSearchBarModel>();
    return SingleChildBuilder(
      builder: (context, child) {
        return MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: child,
        );
      },
      child: Stack(
        children: <Widget>[
          // 内容
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            top: MediaQuery.of(context).padding.top +
                kToolbarHeight +
                (model.isFocus ? -kToolbarHeight : 0),
            bottom: 0,
            left: 0,
            right: 0,
            child: widget.child,
          ),
          // appbar
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            top: MediaQuery.of(context).padding.top +
                (model.isFocus
                    ? (-kToolbarHeight - MediaQuery.of(context).padding.top)
                    : 0),
            left: 0,
            right: 0,
            height: kToolbarHeight,
            child: widget.appbar,
          ),
          // search panel
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            top: MediaQuery.of(context).padding.top +
                (model.isFocus ? -kToolbarHeight : 0) +
                kToolbarHeight +
                Constant.searchBarHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: Offstage(
              offstage: !model.isFocus,
              child: widget.searchPanel,
            ),
          ),
        ],
      ),
    );
  }
}
