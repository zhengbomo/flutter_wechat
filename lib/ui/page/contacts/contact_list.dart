import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/basic.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/ui/view/search_bar.dart';

class ContactList extends StatefulWidget {
  final bool showSearchBar;
  final ThreeValueCallback<DragBehavior, double, bool> dragOffsetChanged;
  final VoidCallback onEdit;
  final VoidCallback cancelCallback;
  final ScrollController scrollController;
  ContactList(
      {@required this.dragOffsetChanged,
      @required this.onEdit,
      this.showSearchBar = true,
      @required this.scrollController,
      @required this.cancelCallback});

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  bool _hasDragDetail = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((_) {
      // _scrollController.animateTo(100,
      // duration: Constant.kCommonDuration, curve: Curves.easeInOut);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      removeBottom: false,
      context: context,
      child: Container(
        // color: Style.primaryColor,
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            var offset = notification.metrics.pixels;
            if (notification is ScrollUpdateNotification) {
              // print("changing ${_focusNode.hasFocus}");
              // 手动滑动
              if (_hasDragDetail) {
                widget.dragOffsetChanged(DragBehavior.dragChanging, offset,
                    notification.dragDetails != null);
              }
            } else if (notification is ScrollEndNotification) {
              // print("end ${_focusNode.hasFocus}");
              if (_hasDragDetail) {
                widget.dragOffsetChanged(DragBehavior.dragEnd, offset,
                    notification.dragDetails != null);
              }
              _hasDragDetail = false;
            } else if (notification is ScrollStartNotification) {
              // print("start ${_focusNode.hasFocus}, ${notification.context}");
              final ScrollStartNotification startNotification = notification;
              if (startNotification.dragDetails != null) {
                _hasDragDetail = true;
                widget.dragOffsetChanged(DragBehavior.dragStart, offset,
                    notification.dragDetails != null);
              }
            } else if (notification is UserScrollNotification) {
              // 方向变化时候触发
              // print(notification);
            } else {
              print(notification);
            }
            return false;
          },
          child: Scrollbar(
            child: CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: widget.scrollController,
              slivers: <Widget>[
                SliverToBoxAdapter(
                    child: SizedBox(
                        height: Constant.listSearchBarHeight,
                        child: Offstage(
                          offstage: !widget.showSearchBar,
                          child: SearchBar(
                            beginEdit: () {
                              widget.onEdit();
                              widget.scrollController.animateTo(0,
                                  duration: Constant.kCommonDuration,
                                  curve: Curves.easeInOut);
                            },
                            cancelCallback: widget.cancelCallback,
                          ),
                        ))),
                SliverSafeArea(
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, i) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
                      height: 100,
                      color: Colors.red,
                      child: Text("$i"),
                    );
                  }, childCount: 10)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum DragBehavior { dragStart, dragChanging, dragEnd }
