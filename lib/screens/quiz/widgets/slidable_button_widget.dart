import 'dart:ui';

import 'package:app_b_804/app_resource/app_colors.dart';
import 'package:flutter/material.dart';


class SlidableButtonWidget extends StatelessWidget {
  const SlidableButtonWidget({
    super.key,
    required this.onPressed,
    this.name,
    required this.price,
    this.onTapRemove,
    this.bottomMargin = 16,
    this.answerIsTrue,
    required this.positionIndex,
  });

  final Function(BuildContext context) onPressed;
  final Function()? onTapRemove;
  final double bottomMargin;
  final String? name;
  final String price;
  final bool? answerIsTrue;
  final int positionIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomMargin),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 40,
            height: 56,
            decoration: BoxDecoration(
              color: answerIsTrue == null
                  ? Colors.black
                  : answerIsTrue!
                  ? Colors.green
                  : Colors.red,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Text(
              positionIndex.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 5),
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: name == null
                    ? Colors.grey[300]
                    : AppColors.buttonBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: answerIsTrue == null
                  ? CustomPaint(
                painter: DashedBorderPainter(
                  color:name == null  ?  Colors.grey.shade400  : AppColors.buttonBackgroundColor,
                  strokeWidth: 2,
                  dashLength: 5,
                  dashSpace: 3,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name ?? '????',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: name == null ? Colors.grey : Colors.white,
                        ),
                      ),
                      Text(
                        '${_formatPrice(int.tryParse(price) ?? 0)}€',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: name == null ? Colors.grey : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  : Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name ?? '????',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: name == null ? Colors.grey : Colors.white,
                      ),
                    ),
                    Text(
                      '${_formatPrice(int.tryParse(price) ?? 0)}€',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: name == null ? Colors.grey : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (name != null)
            GestureDetector(
              onTap: onTapRemove,
              child: Container(
                width: 33,
                alignment: Alignment.center,
                child: const Center(
                  child: Icon(Icons.close, size: 32, color: Colors.black),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatPrice(int price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(1)}K';
    }
    return price.toString();
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpace;
  final BorderRadius borderRadius;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashSpace,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndCorners(
      Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2,
          size.width - strokeWidth, size.height - strokeWidth),
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    final Path path = Path()..addRRect(rrect);

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final PathMetrics pathMetrics = path.computeMetrics();
    for (final PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      bool draw = true;
      while (distance < pathMetric.length) {
        final double length = draw ? dashLength : dashSpace;
        if (draw) {
          canvas.drawPath(
            pathMetric.extractPath(distance, distance + length),
            paint,
          );
        }
        distance += length;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}