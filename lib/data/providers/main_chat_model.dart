import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/models/chat_section_info.dart';

class MainChatModel with ChangeNotifier {
  int changeId = 0;
  List<ChatSectionInfo> sections = List<ChatSectionInfo>();

  bool showMenu = false;

  bool _showApplet = false;
  bool get showApplet => _showApplet;
  set showApplet(bool show) {
    if (_showApplet != show) {
      _showApplet = show;
      notifyListeners();
    }
  }

  double _appletViewTop = 0;
  // 小程序上拉位移
  double get appletViewTop => _appletViewTop;
  set appletViewTop(double scale) {
    if (_appletViewTop != scale) {
      _appletViewTop = scale;
      notifyListeners();
    }
  }

  Duration appletViewDuration = Duration.zero;
  double appletViewAlpha = 0;
  double _appletScale = 0.5;
  // 小程序的缩放
  double get appletScale => _appletScale;
  set appletScale(double scale) {
    if (_appletScale != scale) {
      _appletScale = scale;
      notifyListeners();
    }
  }

  Duration topViewDuration = Constant.kCommonDuration;
  double _topViewTop = 0;
  double get topViewTop => _topViewTop;
  set topViewTop(double top) {
    if (_topViewTop != top) {
      _topViewTop = top;
      notifyListeners();
    }
  }

  AnimationController _animationController;
  AnimationController get animationController => _animationController;

  double _topViewShowOffset = 0;
  double get topViewShowOffset => _topViewShowOffset;
  set topViewShowOffset(double offset) {
    if (_topViewShowOffset != offset) {
      _topViewShowOffset = offset;
      notifyListeners();
    }
  }

  MainChatModel(TickerProvider vsync) {
    _animationController =
        AnimationController(vsync: vsync, duration: Constant.kCommonDuration);
    CurvedAnimation curve =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    curve.addListener(() {
      print(curve.value);
    });
    Tween(begin: 0, end: 1).animate(_animationController);

    sections.addAll(List.generate(20, (index) => ChatSectionInfo.random()));
  }

  void setShowMenu(bool show) {
    if (showMenu != show) {
      showMenu = show;
      notifyListeners();
    }
  }

  void sectionChanged() {
    changeId++;
    notifyListeners();
  }
}
