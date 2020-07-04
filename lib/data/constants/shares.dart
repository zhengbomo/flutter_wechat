import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterwechat/ui/view/no_interactive_ink_feature.dart';
import 'package:random_color/random_color.dart';

class Shares {
  /// 禁用水纹效果工厂
  static final InteractiveInkFeatureFactory noInkFeatureFactory =
      NoSplashFactory();

  static final RandomColor randomColor = RandomColor();
  static final Random random = Random();
}
