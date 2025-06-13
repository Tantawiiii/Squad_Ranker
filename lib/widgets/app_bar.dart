import 'package:app_b_804/app_resource/app_colors.dart';
import 'package:app_b_804/app_resource/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../app_resource/app_images.dart';
import '../core/extensions/app_size_extensions.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final VoidCallback? onBack;
  final Widget? rightWidget;
  final Widget? leftWidget;
  final double leftPadding;

  const CustomAppBar({
    super.key,
    this.title,
    this.onBack,
    this.leftWidget,
    this.rightWidget,
    this.leftPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48 / 852 * AppMediaQueryExtension(context).screenHeight,
      margin: EdgeInsets.only(
        top: 60 / 852 * AppMediaQueryExtension(context).screenHeight,
        left: leftPadding,
        right: 16,
      ),
      child: Row(
        children: [
          leftWidget == null
              ? GestureDetector(
                  onTap: onBack ?? () => Navigator.of(context).pop(),
                  child: Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.indecatorColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      AppImages.arrowBack,
                      width: 24,
                      height: 24,
                    ),
                  ),
                )
              : leftWidget!,
          const Spacer(),
          rightWidget == null
              ? Text(
                  title ?? '',
                  style: AppTextStyles.header24.copyWith(
                    color: AppColors.buttonBackgroundColor,
                  ),
                )
              : rightWidget!,
        ],
      ),
    );
  }
}
