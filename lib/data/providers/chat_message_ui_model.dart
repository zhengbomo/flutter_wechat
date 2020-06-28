import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/page/chats/chat_input_type.dart';
import 'package:quiver/iterables.dart';

class ChatMessageUIModel extends ChangeNotifier {
  final ValueChanged<ChatInputType> chatInputTypeChanged;

  ChatMessageUIModel({this.chatInputTypeChanged});

  double keyboardHeight = 0;

  double inputToolHeight = Constant.chatToolbarMinHeight;

  ChatInputType _chatInputType = ChatInputType.none;

  ChatInputType get chatInputType => _chatInputType;

  bool get isShowInputPanel {
    return _chatInputType == ChatInputType.keyboard ||
        _chatInputType == ChatInputType.emoji ||
        _chatInputType == ChatInputType.more;
  }

  double get messageListBottomHeight {
    return this.bottomHeight + inputToolHeight;
  }

  bool setInputToolHeight(double height, {bool notify = true}) {
    height += Constant.chatToolbarTopBottomPadding * 2;
    var fixHeight = min([
      Constant.chatToolbarMaxHeight,
      max([height, Constant.chatToolbarMinHeight])
    ]);
    fixHeight = fixHeight;
    if (inputToolHeight != fixHeight) {
      inputToolHeight = fixHeight;
      if (notify) {
        notifyListeners();
      }
      return true;
    } else {
      return false;
    }
  }

  double get bottomHeight {
    switch (chatInputType) {
      case ChatInputType.none:
        return 34;
      case ChatInputType.keyboard:
        return keyboardHeight;
      case ChatInputType.emoji:
        return 250;
      case ChatInputType.more:
        return 300;
      case ChatInputType.voice:
        return 34;
      default:
        return 0;
    }
  }

  setKeyboardHeight(double height) {
    keyboardHeight = height;
    notifyListeners();
  }

  setChatInputType(ChatInputType type) {
    if (_chatInputType != type) {
      _chatInputType = type;
      notifyListeners();
      chatInputTypeChanged(type);
    }
  }
}
