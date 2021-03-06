import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class MainBadgeModel with ChangeNotifier, DiagnosticableTreeMixin {
  String messageBadge = "3";
  String contactBadge = "";
  String discoveryBadge;
  String meBadge;
  int selectedIndex;

  bool isShowBottomTabBar = true;

  MainBadgeModel({this.selectedIndex = 0});

  void showBottomTabBar(bool show) {
    if (isShowBottomTabBar != show) {
      isShowBottomTabBar = show;
      notifyListeners();
    }
  }

  void setSelectedIndex(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      notifyListeners();
    }
  }

  void setMessageBadge(String badge) {
    if (messageBadge != badge) {
      messageBadge = badge;
      notifyListeners();
    }
  }

  void setContactBadge(String badge) {
    if (contactBadge != badge) {
      contactBadge = badge;
      notifyListeners();
    }
  }

  void setDiscoveryBadge(String badge) {
    if (discoveryBadge != badge) {
      discoveryBadge = badge;
      notifyListeners();
    }
  }

  void setMeBadge(String badge) {
    if (meBadge != badge) {
      meBadge = badge;
      notifyListeners();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty("message_badge", messageBadge));
  }
}
