import 'package:app_b_804/app_resource/app_colors.dart';
import 'package:app_b_804/app_resource/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../app_resource/app_images.dart';
import '../../../core/extensions/app_size_extensions.dart';

class CoinsRow extends StatelessWidget {
  const CoinsRow({
    super.key,
    required this.coins,
  });
  final String coins;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 48 / 852 * AppMediaQueryExtension(context).screenHeight,
      padding: const EdgeInsets.only(left: 32, right: 8, top: 5, bottom: 5),
      decoration: const BoxDecoration(
        color: AppColors.buttonBackgroundColor,
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            coins,
            style: AppTextStyles.header24.copyWith(fontSize: 20),
          ),
          const SizedBox(width: 6),
          Image.asset(
            AppImages.starIcon,
            width: 28,
            height: 28,
          )
        ],
      ),
    );
  }
}
