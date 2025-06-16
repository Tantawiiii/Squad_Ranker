import 'package:app_b_804/app_resource/app_images.dart';
import 'package:app_b_804/app_resource/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../app_resource/app_colors.dart';
import '../../../app_resource/app_strings.dart';
import '../../../core/extensions/app_size_extensions.dart';

class StartContainer extends StatelessWidget {
  const StartContainer({
    super.key,
    required this.leagueOntap,
    required this.startOnTap,
  });
  final VoidCallback leagueOntap;
  final VoidCallback startOnTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 64 / 852 * AppMediaQueryExtension(context).screenHeight,
        bottom: 24 / 852 * AppMediaQueryExtension(context).screenHeight,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.indecatorColor,
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.only(top: 14, bottom: 32),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IntrinsicWidth(
              child: GestureDetector(
                onTap: leagueOntap,
                child: Container(
                  height:
                      55 / 852 * AppMediaQueryExtension(context).screenHeight,
                  margin: const EdgeInsets.only(right: 14),
                  decoration: BoxDecoration(
                      color: AppColors.buttonBackgroundColor,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.only(
                      left: 15, right: 10, top: 8, bottom: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(AppImages.leaguesIcon, width: 32, height: 32),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 4),
                        child: Text(
                          AppStrings.leagues,
                          style: AppTextStyles.header24.copyWith(fontSize: 20),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.indecatorColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical:
                    78 / 852 * AppMediaQueryExtension(context).screenHeight),
            child: Image.asset(AppImages.squadRankerIcon),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: startOnTap,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.yellow,
                  foregroundColor: AppColors.buttonBackgroundColor,
                ),
                child: Text(
                  AppStrings.start.toUpperCase(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
