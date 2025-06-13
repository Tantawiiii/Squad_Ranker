import 'package:app_b_804/app_resource/app_colors.dart';
import 'package:app_b_804/app_resource/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../app_resource/app_images.dart';
import '../../../app_resource/app_strings.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Image.asset(
              AppImages.noInternetIcon,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            Text(
              AppStrings.noInternet,
              style: AppTextStyles.header16.copyWith(fontSize: 14),
            ),
            const Spacer(),
            TextButton(
              onPressed: onTap,
              child: Text(
                AppStrings.retry,
                style: AppTextStyles.header16
                    .copyWith(color: AppColors.indecatorColor),
              ),
            )
          ],
        ));
  }
}
