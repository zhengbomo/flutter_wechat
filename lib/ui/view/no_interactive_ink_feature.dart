import 'package:flutter/material.dart';


// 空水纹实现工厂
class NoSplashFactory extends InteractiveInkFeatureFactory {
  @override
  InteractiveInkFeature create({MaterialInkController controller, RenderBox referenceBox, Offset position, Color color, TextDirection textDirection, bool containedInkWell = false, rectCallback, BorderRadius borderRadius, ShapeBorder customBorder, double radius, onRemoved}) {
    return _NoInteractiveInkFeature(controller: controller, referenceBox: referenceBox);
  }
}

// 空实现
class _NoInteractiveInkFeature extends InteractiveInkFeature {
  _NoInteractiveInkFeature({
    @required MaterialInkController controller,
    @required RenderBox referenceBox,
  }) : super(controller: controller, referenceBox: referenceBox);

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}