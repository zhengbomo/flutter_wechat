import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/ui/components/action_sheet.dart';
import 'package:flutterwechat/ui/components/avatar.dart';
import 'package:flutterwechat/ui/components/child_builder.dart';
import 'package:flutterwechat/ui/page/chats/chat_editor.dart';
import 'package:flutterwechat/ui/page/chats/view/emoji_panel/emoji_panel_emoji.dart';
import 'package:flutterwechat/ui/page/discover/moment_cell.dart';
import 'package:flutterwechat/ui/page/discover/moment_info.dart';
import 'package:flutterwechat/ui/page/discover/moment_list_provider.dart';
import 'package:flutterwechat/ui/page/discover/moment_operate_more.dart';
import 'package:flutterwechat/ui/view/bm_appbar.dart';
import 'package:keyboard_utils/keyboard_listener.dart';
import 'package:keyboard_utils/keyboard_utils.dart';
import 'package:provider/provider.dart';

class MomentListPage extends StatefulWidget {
  @override
  _MomentListPageState createState() => _MomentListPageState();
}

class _MomentListPageState extends State<MomentListPage> {
  final ScrollController _scrollController = ScrollController();

  final _momentListProvider = MomentListProvider();

  final _BottomViewModel _bottomViewModel = _BottomViewModel();

  final FocusNode _focusNode = FocusNode();

  final ChatEditorModel _chatEditorModel = ChatEditorModel();

  KeyboardUtils _keyboardUtils = KeyboardUtils();

  // 键盘事件
  int _subscribingId;

  // 键盘弹出时，需要滚动的位置
  double _scrollOffset = 0;

  // 当前的moment
  MomentInfo _currentMoment;

  @override
  void initState() {
    _subscribingId = _keyboardUtils.add(
      listener: KeyboardListener(willShowKeyboard: (height) {
        print(height);
        _bottomViewModel.keyboardHeight = height;
        _scrollController.animateTo(
            _scrollOffset + _bottomViewModel.bottomHeight,
            duration: Constant.kCommonDuration,
            curve: Curves.easeInOut);
      }, willHideKeyboard: () {
        // 隐藏键盘
      }),
    );
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // 获得焦点
        _bottomViewModel.inputType = _InputType.keyboard;
      } else {
        // 失去焦点
        if (_bottomViewModel.inputType == _InputType.keyboard) {
          _bottomViewModel.inputType = _InputType.none;
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _keyboardUtils.unsubscribeListener(subscribingId: _subscribingId);
    _keyboardUtils.dispose();
    super.dispose();
  }

  GlobalKey _listViewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    BuildContext rootContext = context;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PrimaryScrollController(
        controller: _scrollController,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: _momentListProvider),
            ChangeNotifierProvider.value(value: _bottomViewModel),
          ],
          child: ChildBuilder4(
            child1: Builder(builder: (context) {
              final threadshold = 0.8;
              final originOffset = context.select(
                  (MomentListProvider value) => value.appbarBackgroundAlpha);
              final offset =
                  max(0, originOffset - threadshold) * (1 / (1 - threadshold));
              final alpha = (offset * 255).toInt();
              return BMAppBar(
                color: originOffset < threadshold ? Colors.white : Colors.black,
                backgroundColor: Style.primaryColor.withAlpha(alpha),
                title: Text(
                  "朋友圈",
                  style: TextStyle(color: Colors.black.withAlpha(alpha)),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: SvgPicture.asset(
                      Constant.assetsImagesMe.named("icons_filled_camera.svg"),
                      color: originOffset < threadshold
                          ? Colors.white
                          : Colors.black,
                    ),
                    onPressed: () {
                      _publishChoose(context);
                    },
                  )
                ],
              );
            }),
            child2: Builder(builder: (context) {
              final bottomModel = _bottomViewModel;
              return MomentOperateMore(
                hasLiked: (_currentMoment == null)
                    ? false
                    : _currentMoment.likes.contains("八戒"),
                top: context
                    .select((MomentListProvider model) => model.operateMoreTop),
                show: context.select(
                    (MomentListProvider model) => model.showOperateMore),
                dismiss: () {
                  _momentListProvider.setOperateMoreTop(show: false);
                },
                onComment: () {
                  if (bottomModel.inputType == _InputType.none) {
                    _focusNode.requestFocus();
                  }
                  _momentListProvider.setOperateMoreTop(show: false);
                },
                onLike: () {
                  var likes = _currentMoment.likes;
                  if (likes.contains("八戒")) {
                    likes.remove("八戒");
                  } else {
                    likes.add("八戒");
                  }
                  _momentListProvider.momentChanged();
                  _momentListProvider.setOperateMoreTop(show: false);
                },
              );
            }),
            child3: Provider.value(
              value: _chatEditorModel,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: CupertinoTextField(
                            scrollController:
                                _chatEditorModel.textScrollController,
                            textInputAction: TextInputAction.send,
                            controller: _chatEditorModel.editingController,
                            onSubmitted: (text) {
                              _currentMoment.comments.add(MomentCommentInfo()
                                ..username = "八戒"
                                ..content = text);
                              _chatEditorModel.editingController.text = "";
                              _momentListProvider.momentChanged();
                            },
                            focusNode: _focusNode,
                            // autofocus: true,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          Constant.assetsImagesChatBar
                              .named("chat_bar_emoji.svg"),
                          color: Colors.black,
                        ),
                        onPressed: () {
                          final oldOffset = _bottomViewModel.bottomHeight;
                          _bottomViewModel.inputType = _InputType.emoji;
                          final newOffset = _bottomViewModel.bottomHeight;

                          _scrollController.animateTo(
                              _scrollController.offset +
                                  (newOffset - oldOffset),
                              duration: Constant.kCommonDuration,
                              curve: Curves.easeInOut);
                          if (_focusNode.hasFocus) {
                            _focusNode.unfocus();
                          }
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      child: EmojiPanelEmoji(),
                      removeTop: true,
                    ),
                  ),
                ],
              ),
            ),
            child4: Builder(builder: (context) {
              // 用于更新数据
              context
                  .select((MomentListProvider model) => model.momentChangeId);

              final moments = _momentListProvider.moments;
              final count = moments.length;

              return ListView.builder(
                key: _listViewKey,
                primary: true,
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return _createHeader(context);
                  } else if (i == count + 1) {
                    return Builder(builder: (context) {
                      return SizedBox(
                        height: context.select(
                            (_BottomViewModel model) => model.bottomPadding),
                      );
                    });
                  } else {
                    final momentInfo = moments[i - 1];
                    return MomentCell(
                      momentInfo: momentInfo,
                      comment: (listItemOffset, renderBox) {
                        // 获取位置
                        RenderBox listViewRenderBox =
                            _listViewKey.currentContext.findRenderObject();
                        // 目标box相对listView的位置
                        final listViewOffset = renderBox.localToGlobal(
                            Offset.zero,
                            ancestor: listViewRenderBox);

                        final moveOffset = listViewRenderBox.size.height -
                            (listViewOffset.dy + renderBox.size.height);

                        // item相对listView的位置
                        final itemOffset =
                            _scrollController.offset - moveOffset;
                        _scrollOffset = itemOffset;
                        _focusNode.requestFocus();
                        _currentMoment = momentInfo;
                      },
                      moreOperate: (globalOffset, listItemOffset, renderBox) {
                        // 获取位置
                        RenderBox listViewRenderBox =
                            _listViewKey.currentContext.findRenderObject();

                        // 目标box相对listView的位置
                        final listViewOffset = renderBox.localToGlobal(
                            Offset.zero,
                            ancestor: listViewRenderBox);

                        // 向下移动距离
                        final moveOffset = listViewRenderBox.size.height -
                            (listViewOffset.dy + renderBox.size.height);

                        // item相对listView的位置
                        final itemOffset =
                            _scrollController.offset - moveOffset;
                        _scrollOffset = itemOffset;
                        final model = _momentListProvider;
                        if (model.showOperateMore) {
                          model.setOperateMoreTop(show: false);
                        } else {
                          model.setOperateMoreTop(
                              show: true, top: globalOffset.dy);
                        }
                        _currentMoment = momentInfo;
                      },
                    );
                  }
                },
                itemCount: count + 2,
              );
            }),
            builder: (context, child1, child2, child3, child4) {
              final viewHeight = MediaQuery.of(context).size.height;
              final paddingTop = MediaQuery.of(context).padding.top;

              final bottomModel = context.watch<_BottomViewModel>();
              return Stack(
                children: <Widget>[
                  // 列表
                  MediaQuery.removePadding(
                    removeTop: true,
                    removeBottom: true,
                    context: context,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        final pixels = notification.metrics.pixels -
                            notification.metrics.minScrollExtent;

                        const maxValue = 300.0;
                        final offset = min(maxValue, max(0.0, pixels));
                        final alpha = offset / maxValue;
                        _momentListProvider.setAppBarBackgroundAlpha(alpha);
                        return false;
                      },
                      child: child4,
                    ),
                  ),
                  // appbar
                  Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      height: paddingTop + kToolbarHeight,
                      child: child1),
                  // OperateMore
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: child2,
                  ),
                  // 遮罩用于点击关闭
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Offstage(
                      offstage: bottomModel.inputType == _InputType.none,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onPanDown: (_) {
                          if (bottomModel.inputType == _InputType.keyboard) {
                            _focusNode.unfocus();
                          } else if (bottomModel.inputType ==
                              _InputType.emoji) {
                            bottomModel.inputType = _InputType.none;
                          }
                        },
                      ),
                    ),
                  ),
                  // input
                  AnimatedPositioned(
                    duration: Constant.kCommonDuration,
                    curve: Curves.easeInOut,
                    left: 0,
                    right: 0,
                    top: viewHeight - bottomModel.bottomPadding,
                    height: bottomModel.bottomHeight,
                    child: Container(
                      color: Color(0xffefefef),
                      height: bottomModel.bottomHeight,
                      child: child3,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _createHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 40,
            child: Container(
              color: Colors.green,
            ),
          ),
          Positioned(
            right: 12,
            bottom: 18,
            width: 68,
            height: 68,
            child: Avatar(
              borderRadius: 8,
              color: Colors.blue,
            ),
          ),
          Positioned(
            right: 12.0 + 60 + 32,
            bottom: 48,
            child: Container(
              child: Text(
                "八戒",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 2,
                      offset: Offset.zero,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _publishChoose(BuildContext context) {
    ActionSheet(
      itemCount: 2,
      itemBuilder: (c, i) {
        if (i == 0) {
          return SizedBox(
            height: 70,
            child: FlatButton(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "拍摄",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "照片或视��",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black26,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        } else {
          return SizedBox(
            height: 60,
            child: FlatButton(
              padding: EdgeInsets.zero,
              child: Text(
                "从手机相册选择",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        }
      },
    ).show(context);
  }
}

enum _InputType { none, emoji, keyboard }

class _BottomViewModel extends ChangeNotifier {
  double _keyboardHeight = 0;
  _InputType _inputType = _InputType.none;

  double textViewHeight = 50;

  double get bottomPadding {
    switch (_inputType) {
      case _InputType.emoji:
      case _InputType.keyboard:
        return this.bottomHeight;
      case _InputType.none:
        return 0;
    }
    return 0;
  }

  double get bottomHeight {
    switch (_inputType) {
      case _InputType.emoji:
        return 300 + textViewHeight;
      case _InputType.none:
        return textViewHeight;
      case _InputType.keyboard:
        return _keyboardHeight + textViewHeight;
    }
    return 0;
  }

  double get keyboardHeight => _keyboardHeight;
  set keyboardHeight(double height) {
    if (_keyboardHeight != height) {
      _keyboardHeight = height;
      notifyListeners();
    }
  }

  _InputType get inputType => _inputType;
  set inputType(_InputType type) {
    if (_inputType != type) {
      _inputType = type;
      notifyListeners();
    }
  }
}
