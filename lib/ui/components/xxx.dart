// import 'package:flutter/material.dart';

// abstract class BasePainter extends CustomPainter {
//   final PageIndicator widget;
//   final double page;
//   final int index;
//   final Paint _paint;

//   double lerp(double begin, double end, double progress) {
//     return begin + (end - begin) * progress;
//   }

//   BasePainter(this.widget, this.page, this.index, this._paint);

//   void draw(Canvas canvas, double space, double size, double radius);

//   bool _shouldSkip(int index) {
//     return false;
//   }
//   //double secondOffset = index == widget.count-1 ? radius : radius + ((index + 1) * (size + space));

//   @override
//   void paint(Canvas canvas, Size size) {
//     _paint.color = widget.color;
//     double space = widget.space;
//     double size = widget.size;
//     double radius = size / 2;
//     for (int i = 0, c = widget.count; i < c; ++i) {
//       if (_shouldSkip(i)) {
//         continue;
//       }
//       canvas.drawCircle(
//           new Offset(i * (size + space) + radius, radius), radius, _paint);
//     }

//     double page = this.page;
//     if (page < index) {
//       page = 0.0;
//     }
//     _paint.color = widget.activeColor;
//     draw(canvas, space, size, radius);
//   }

//   @override
//   bool shouldRepaint(BasePainter oldDelegate) {
//     return oldDelegate.page != page;
//   }
// }

// class ColorPainter extends BasePainter {
//   ColorPainter(PageIndicator widget, double page, int index, Paint paint)
//       : super(widget, page, index, paint);

//   // 连续的两个点，含有最后一个和第一个
//   @override
//   bool _shouldSkip(int i) {
//     if (index == widget.count - 1) {
//       return i == 0 || i == index;
//     }
//     return (i == index || i == index + 1);
//   }

//   @override
//   void draw(Canvas canvas, double space, double size, double radius) {
//     double progress = page - index;
//     double secondOffset = index == widget.count - 1
//         ? radius
//         : radius + ((index + 1) * (size + space));

//     _paint.color = Color.lerp(widget.activeColor, widget.color, progress);
//     //left
//     canvas.drawCircle(
//         new Offset(radius + (index * (size + space)), radius), radius, _paint);
//     //right
//     _paint.color = Color.lerp(widget.color, widget.activeColor, progress);
//     canvas.drawCircle(new Offset(secondOffset, radius), radius, _paint);
//   }
// }
