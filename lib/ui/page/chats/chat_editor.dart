import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/providers/chat_message_ui_model.dart';
import 'package:flutterwechat/ui/page/chats/chat_input_type.dart';
import 'package:flutterwechat/ui/view/sized_icon_button.dart';
import 'package:keyboard_utils/keyboard_listener.dart';
import 'package:keyboard_utils/keyboard_utils.dart';
import 'package:provider/provider.dart';

class ChatEditor extends StatefulWidget {
  final ValueChanged<bool> textViewHeightChanged;

  ChatEditor({this.textViewHeightChanged});

  @override
  _ChatEditorState createState() => _ChatEditorState();
}

class _ChatEditorState extends State<ChatEditor>
    with SingleTickerProviderStateMixin {
  FocusNode _focusNode = FocusNode();
  TextEditingController _editingController;
  KeyboardUtils _keyboardUtils = KeyboardUtils();
  int _subscribingId;

  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    _editingController =
        TextEditingController(text: "mmmmmmmmmmmmmmmmmm mmmmmmmmmmmmmmmmmm");
    _subscribingId = _keyboardUtils.add(
        listener: KeyboardListener(willShowKeyboard: (height) {
      var model = context.read<ChatMessageUIModel>();
      model.keyboardHeight = height;
      // 更新toolheight
      _updateTextToolHeight(model);
      model.setChatInputType(ChatInputType.keyboard);
    }, willHideKeyboard: () {
      var model = context.read<ChatMessageUIModel>();
      model.keyboardHeight = 0;
      if (model.chatInputType == ChatInputType.keyboard) {
        model.setChatInputType(ChatInputType.none);
      }
    }));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var model = context.read<ChatMessageUIModel>();
      _updateTextToolHeight(model, notify: true);
      widget.textViewHeightChanged(true);
    });

    super.initState();
  }

  _updateTextToolHeight(ChatMessageUIModel model, {bool notify: false}) {
    // 更新toolheight
    var textViewHeight =
        _textFieldKey.currentContext.findRenderObject().paintBounds.size.height;
    if (textViewHeight != model.inputToolHeight) {
      model.setInputToolHeight(textViewHeight, notify: notify);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _keyboardUtils.unsubscribeListener(subscribingId: _subscribingId);
    super.dispose();
  }

  GlobalKey _textFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
        // color: Style.chatToolbarBackgroundColor.withAlpha(200),
        color: Colors.green.withAlpha(150),
        child: SafeArea(
            top: false,
            bottom: false,
            child: Column(
              children: <Widget>[
                Padding(
                  key: _globalKey,
                  padding: EdgeInsets.fromLTRB(
                      0,
                      Constant.chatToolbarTopBottomPadding,
                      0,
                      Constant.chatToolbarTopBottomPadding),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        SizedIconButton(
                          height: Constant.chatToolbarMinHeight -
                              Constant.chatToolbarTopBottomPadding * 2,
                          width: Constant.chatToolbarMinHeight -
                              Constant.chatToolbarTopBottomPadding * 2,
                          onPressed: () {
                            var model = context.read<ChatMessageUIModel>();
                            if (model.chatInputType != ChatInputType.voice) {
                              if (model.chatInputType ==
                                  ChatInputType.keyboard) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                              model.setInputToolHeight(
                                  Constant.chatToolbarMinHeight -
                                      Constant.chatToolbarTopBottomPadding * 2);
                              model.setChatInputType(ChatInputType.voice);
                            } else {
                              _focusNode.requestFocus();
                              // model.setChatInputType(ChatInputType.keyboard);
                            }
                          },
                          icon: Icon(context
                                      .watch<ChatMessageUIModel>()
                                      .chatInputType ==
                                  ChatInputType.voice
                              ? Icons.blur_off
                              : Icons.blur_on),
                        ),
                        Expanded(
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: Constant.chatToolbarMaxHeight -
                                        Constant.chatToolbarTopBottomPadding *
                                            2,
                                    minHeight: Constant.chatToolbarMinHeight -
                                        Constant.chatToolbarTopBottomPadding *
                                            2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  // index: _indexForCenterInput(context),
                                  children: <Widget>[
                                    Offstage(
                                        offstage: context
                                                .watch<ChatMessageUIModel>()
                                                .chatInputType ==
                                            ChatInputType.voice,
                                        child: CupertinoTextField(
                                          key: _textFieldKey,
                                          style: TextStyle(fontSize: 18),
                                          // expands: true,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          minLines: 1,
                                          focusNode: _focusNode,
                                          placeholder: "ddd",
                                          controller: _editingController,
                                          onChanged: (text) {
                                            _onTextChanged(context);
                                          },
                                        )),
                                    Offstage(
                                      offstage: context
                                              .watch<ChatMessageUIModel>()
                                              .chatInputType !=
                                          ChatInputType.voice,
                                      child: SizedBox(
                                        height: 40,
                                        child: FlatButton(
                                          color: Color(0xffdcdcdc),
                                          onPressed: () {},
                                          child: Text("按住说话"),
                                        ),
                                      ),
                                    )
                                  ],
                                ))),
                        SizedIconButton(
                          height: Constant.chatToolbarMinHeight -
                              Constant.chatToolbarTopBottomPadding * 2,
                          width: Constant.chatToolbarMinHeight -
                              Constant.chatToolbarTopBottomPadding * 2,
                          onPressed: () {
                            var model = context.read<ChatMessageUIModel>();
                            if (model.chatInputType == ChatInputType.keyboard) {
                              _focusNode.unfocus();
                            }
                            _updateTextToolHeight(model);
                            model.setChatInputType(ChatInputType.emoji);
                          },
                          icon: Icon(Icons.people),
                        ),
                        SizedIconButton(
                          height: Constant.chatToolbarMinHeight -
                              Constant.chatToolbarTopBottomPadding * 2,
                          width: Constant.chatToolbarMinHeight -
                              Constant.chatToolbarTopBottomPadding * 2,
                          onPressed: () {
                            var model = context.read<ChatMessageUIModel>();
                            if (model.chatInputType == ChatInputType.keyboard) {
                              _focusNode.unfocus();
                            }
                            _updateTextToolHeight(model);
                            model.setChatInputType(ChatInputType.more);
                          },
                          icon: Icon(Icons.people),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedSize(
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 250),
                  vsync: this,
                  child: SizedBox(
                      height: context.watch<ChatMessageUIModel>().bottomHeight),
                ),
              ],
            )));
  }

  _onTextChanged(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var height = _textFieldKey.currentContext
          .findRenderObject()
          .paintBounds
          .size
          .height;
      var height2 = _textFieldKey.currentContext
          .findRenderObject()
          .paintBounds
          .size
          .height;
      print("$height, $height2");
      var model = context.read<ChatMessageUIModel>();
      if (height != model.inputToolHeight) {
        // scroll to end
        if (model.setInputToolHeight(height)) {
          widget.textViewHeightChanged(false);
        }
      }
    });
  }

  int _indexForCenterInput(BuildContext context) {
    var chatInputType = context.watch<ChatMessageUIModel>().chatInputType;
    switch (chatInputType) {
      case ChatInputType.voice:
        return 1;
      default:
        return 0;
    }
  }
}
