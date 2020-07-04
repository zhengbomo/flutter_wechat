import 'package:flutter/material.dart';
import 'package:flutterwechat/data/providers/list_search_bar_model.dart';
import 'package:flutterwechat/ui/view/search_bar.dart';
import 'package:provider/provider.dart';

typedef WidgetBuilder1<T> = Widget Function(BuildContext context, T searchBar);

final double _searchHeight = 50;

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
                height: _searchHeight,
                child: SearchBar(beginEdit: () {
                  context.read<ListSearchBarModel>().changeFocus(true);
                }, cancelCallback: () {
                  context.read<ListSearchBarModel>().changeFocus(false);
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
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            top: MediaQuery.of(context).padding.top +
                kToolbarHeight +
                (context.watch<ListSearchBarModel>().isFocus
                    ? -kToolbarHeight
                    : 0),
            bottom: 0,
            left: 0,
            right: 0,
            child: widget.child,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            top: MediaQuery.of(context).padding.top +
                (context.watch<ListSearchBarModel>().isFocus
                    ? -kToolbarHeight
                    : 0),
            left: 0,
            right: 0,
            height: kToolbarHeight,
            child: widget.appbar,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            top: MediaQuery.of(context).padding.top +
                (context.watch<ListSearchBarModel>().isFocus
                    ? -kToolbarHeight
                    : 0) +
                kToolbarHeight +
                _searchHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: Offstage(
              offstage: !context.watch<ListSearchBarModel>().isFocus,
              child: widget.searchPanel,
            ),
          ),
        ],
      ),
    );
  }
}
