import 'dart:io';

import 'package:flutter/material.dart';

// 统一iOS的ScrollView
class SameScrollBehavior extends ScrollBehavior {
  const SameScrollBehavior();

  @override
  TargetPlatform getPlatform(BuildContext context) {
    final platform = Theme.of(context).platform;
    if (platform == TargetPlatform.android) {
      return TargetPlatform.iOS;
    } else {
      return platform;
    }
  }

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    } else {
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}
