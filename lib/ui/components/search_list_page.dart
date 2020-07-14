import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/providers/list_search_bar_model.dart';
import 'package:flutterwechat/data/providers/main_badge_model.dart';
import 'package:flutterwechat/ui/components/child_builder.dart';
import 'package:flutterwechat/ui/view/search_bar.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

typedef WidgetBuilder1<T> = Widget Function(BuildContext context, T searchBar);

class SearchListPage extends StatelessWidget {
  final Widget appbar;
  final Widget searchPanel;
  final WidgetBuilder1<Widget> builder;
  final ListSearchBarModel listSearchBarModel;

  SearchListPage({
    @required this.appbar,
    ListSearchBarModel listSearchBarModel,
    @required this.searchPanel,
    @required this.builder,
  }) : this.listSearchBarModel = listSearchBarModel ?? ListSearchBarModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => listSearchBarModel,
      child: ChildBuilder1(
        child1: this.builder(context, Builder(builder: (context) {
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
        })),
        builder: (context, child1) {
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            body: ChildBuilder2(
              builder: (context, appbar, searchPanel) {
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
                        duration: Constant.kCommonDuration,
                        top: MediaQuery.of(context).padding.top +
                            kToolbarHeight +
                            (model.isFocus
                                ? -kToolbarHeight
                                : context.select((ListSearchBarModel model) =>
                                    model.listViewOffset)),
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: child1,
                      ),
                      // appbar
                      AnimatedPositioned(
                        duration: context.select(
                            (ListSearchBarModel model) => model.appbarDuration),
                        top: MediaQuery.of(context).padding.top +
                            (model.isFocus
                                ? (-kToolbarHeight -
                                    MediaQuery.of(context).padding.top)
                                : context.select((ListSearchBarModel model) =>
                                    model.appbarOffset)),
                        left: 0,
                        right: 0,
                        height: kToolbarHeight,
                        child: appbar,
                      ),
                      // search panel
                      AnimatedPositioned(
                        duration: Constant.kCommonDuration,
                        top: MediaQuery.of(context).padding.top +
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
                    ],
                  ),
                );
              },
              child1: this.appbar,
              child2: this.searchPanel,
            ),
          );
        },
      ),
    );
  }
}
