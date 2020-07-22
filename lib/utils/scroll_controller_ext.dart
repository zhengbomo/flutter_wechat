import 'dart:math';
import 'package:flutter/material.dart';

/// 字符串扩展方法
extension ScrollControllerExtension on ScrollController {
  // 滑动位置到中间
  Future<void> scrollToCenter(
      {double offset, Duration duration, Curve curve}) async {
    final halfViewPort = this.position.viewportDimension * 0.5;
    var newOffset = offset - halfViewPort;
    newOffset = min(newOffset, this.position.maxScrollExtent);
    newOffset = max(newOffset, this.position.minScrollExtent);
    if (this.offset != newOffset) {
      return this.animateTo(newOffset, duration: duration, curve: curve);
    }
  }

  void safeJumpTo(double value) {
    final offset = max(min(value, this.position.maxScrollExtent),
        this.position.minScrollExtent);
    position.jumpTo(offset);
  }

  /// 是否到底了
  bool get isReachEnd => this.offset >= this.position.maxScrollExtent;
}
