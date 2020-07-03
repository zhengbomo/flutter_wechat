import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimatedScale extends ImplicitlyAnimatedWidget {
  /// Creates a widget that animates its opacity implicitly.
  ///
  /// The [opacity] argument must not be null and must be between 0.0 and 1.0,
  /// inclusive. The [curve] and [duration] arguments must not be null.
  const AnimatedScale({
    Key key,
    this.child,
    @required this.scale,
    Curve curve = Curves.linear,
    @required Duration duration,
    this.valueChanged,
    VoidCallback onEnd,
  })  : assert(scale != null && scale >= 0.0 && scale <= 1.0),
        super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  final double scale;

  final ValueChanged<double> valueChanged;

  @override
  _AnimatedScaleState createState() => _AnimatedScaleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('scale', scale));
  }
}

class _AnimatedScaleState extends ImplicitlyAnimatedWidgetState<AnimatedScale> {
  Tween<double> _scale;
  Animation<double> _scaleAnimation;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _scale = visitor(_scale, widget.scale,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>;
  }

  @override
  void didUpdateTweens() {
    print("dd");

    animation.removeListener(_handler);
    animation.addListener(_handler);

    _scaleAnimation = animation.drive(_scale);
  }

  _handler() {
    if (widget.valueChanged != null) {
      widget.valueChanged(animation.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      alignment: Alignment.topCenter,
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}
