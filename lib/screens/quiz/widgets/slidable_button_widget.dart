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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(left: 5),
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: answerIsTrue == null
                    ? null
                    : Border.all(
                  width: 2,
                  color: answerIsTrue!
                      ? Colors.green
                      : Colors.red,
                ),
                color: name == null
                    ? Colors.grey[300]
                    : Colors.blue[100],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name ?? '????',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: name == null ? Colors.grey : Colors.black,
                    ),
                  ),
                  Text(
                    '${_formatPrice(int.tryParse(price) ?? 0)}€',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
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
                  child: Icon(Icons.close, size: 24, color: Colors.red),
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
