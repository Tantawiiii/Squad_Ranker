import 'package:app_b_804/app_resource/app_colors.dart';
import 'package:app_b_804/app_resource/app_strings.dart';
import 'package:app_b_804/app_resource/app_text_styles.dart';
import 'package:flutter/material.dart';

class LoadMoreWidget extends StatelessWidget {
  const LoadMoreWidget({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          AppStrings.loadMore,
          style: AppTextStyles.header16,
        ),
      ),
    );
  }
}
