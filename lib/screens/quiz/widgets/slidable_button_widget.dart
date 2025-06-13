import 'package:flutter/material.dart';

import '../../../app_resource/app_colors.dart';
import '../../../app_resource/app_text_styles.dart';

class SlidableButtonWidget extends StatelessWidget {
  const SlidableButtonWidget({
    super.key,
    required this.onPressed,
    this.name,
    required this.price,
    this.onTapRemove,
    this.bottomMargin = 16,
    this.answerIsTrue,
  });
  final Function(BuildContext context) onPressed;
  final Function()? onTapRemove;
  final double bottomMargin;
  final String? name;
  final String price;
  final bool? answerIsTrue;
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
                  ? AppColors.buttonBackgroundColor
                  : answerIsTrue!
                      ? AppColors.trueAnswerColor
                      : AppColors.indecatorColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Text(
              '1',
              style: AppTextStyles.header16.copyWith(),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              margin: const EdgeInsets.only(
                left: 5,
              ),
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: answerIsTrue == null
                    ? null
                    : Border.all(
                        width: 2,
                        color: answerIsTrue!
                            ? AppColors.trueAnswerColor
                            : AppColors.indecatorColor,
                      ),
                image: name == null
                    ? const DecorationImage(
                        image: AssetImage(
                          "assets/images/borderBloc.png",
                        ),
                        fit: BoxFit.fill)
                    : null,
                color: name == null
                    ? AppColors.leaugeElementsColor
                    : AppColors.buttonBackgroundColor,
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
                    style: AppTextStyles.header16.copyWith(
                      color: name == null ? AppColors.lightGray : null,
                    ),
                  ),
                  Text(
                    '$price\$',
                    style: AppTextStyles.header16.copyWith(
                      color: AppColors.buttonBackgroundColor,
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
                child: Center(
                  child: Image.asset(
                    "assets/images/removeIcon.png",
                    width: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
