import 'package:app_b_804/app_resource/app_colors.dart';
import 'package:app_b_804/app_resource/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../app_resource/app_strings.dart';

enum CheckBox {
  checkBoxIsClosed,
  checkBoxIsSellected,
  checkBoxIsNotSelleted,
}

class LeaugesWidget extends StatelessWidget {
  const LeaugesWidget({
    super.key,
    this.openedTitle,
    this.checkBoxType,
    this.closedTitle,
    this.scored,
    this.isActive = true,
    this.isNew = false,
    this.checkOnTap,
    this.leaugeOnTap,
    this.marginBottom = 10,
  });
  final String? openedTitle;
  final String? closedTitle;
  final String? scored;
  final CheckBox? checkBoxType;
  final bool isActive;
  final bool isNew;
  final Function()? checkOnTap;
  final Function()? leaugeOnTap;
  final double marginBottom;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: leaugeOnTap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: marginBottom,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.leaugeElementsColor
              : AppColors.leaugeElementsColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (openedTitle != null)
              Text(
                openedTitle!,
                style: AppTextStyles.header16.copyWith(
                  color: AppColors.buttonBackgroundColor,
                  overflow: TextOverflow.ellipsis
                ),
                overflow: TextOverflow.ellipsis,
              ),
            if (isNew) const Spacer(),
            if (isNew)
              Text(
                AppStrings.newText,
                style: AppTextStyles.header16.copyWith(
                  color: AppColors.trueAnswerColor,
                  fontSize: 12,
                ),
              ),
            if (checkBoxType != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: checkBoxType == CheckBox.checkBoxIsNotSelleted
                      ? GestureDetector(
                          onTap: checkOnTap,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                width: 2,
                                color: AppColors.buttonBackgroundColor,
                              ),
                            ),
                          ),
                        )
                      : checkBoxType == CheckBox.checkBoxIsSellected
                          ? GestureDetector(
                              onTap: checkOnTap,
                              child: Image.asset(
                                'assets/images/check.png',
                                width: 24,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Image.asset(
                              'assets/images/checkInactive.png',
                              width: 24,
                              fit: BoxFit.fill,
                            ),
                ),
              ),
            if (closedTitle != null)
              Row(
                children: [
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: Image.asset(
                      'assets/images/leaugeBlock.png',
                      width: 24,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    closedTitle!,
                    style: AppTextStyles.header16.copyWith(
                      color: AppColors.lightGray,
                    ),
                  ),
                ],
              ),
            if (scored != null)
              Row(
                children: [
                  Text(
                    scored!,
                    style: AppTextStyles.header16.copyWith(
                      color: AppColors.buttonBackgroundColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      'assets/images/star_icon.png',
                      width: 24,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
