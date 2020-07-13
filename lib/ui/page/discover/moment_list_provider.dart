import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/ui/page/discover/moment_info.dart';

class MomentListProvider extends ChangeNotifier {
  //用于标识moment列表变化
  int momentChangeId = 0;

  List<MomentInfo> moments = List.generate(20, (index) => MomentInfo.random());

  double operateMoreTop = 0;
  bool showOperateMore = false;

  double appbarBackgroundAlpha = 0;
  Color get appbarBackgroundColor =>
      Style.primaryColor.withAlpha((this.appbarBackgroundAlpha * 255).toInt());

  setAppBarBackgroundAlpha(double alpha) {
    if (appbarBackgroundAlpha != alpha) {
      appbarBackgroundAlpha = alpha;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        notifyListeners();
      });
    }
  }

  setOperateMoreTop({double top, @required bool show}) {
    var needNotify = false;
    if (show != null && showOperateMore != show) {
      showOperateMore = show;
      needNotify = true;
    }
    if (top != null && operateMoreTop != top) {
      operateMoreTop = top;
      needNotify = true;
    }
    if (needNotify) {
      notifyListeners();
    }
  }

  momentChanged() {
    momentChangeId++;
    notifyListeners();
  }
}
