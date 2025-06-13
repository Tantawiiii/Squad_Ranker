import 'package:app_b_804/app_resource/app_colors.dart';
import 'package:flutter/material.dart';
import '../../app_resource/app_images.dart';
import '../../app_resource/app_strings.dart';
import '../../app_resource/app_text_styles.dart';
import '../../core/database/database.dart';
import '../../core/extensions/app_size_extensions.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(
            top: 40 / 852 * AppMediaQueryExtension(context).screenHeight),
        color: AppColors.indecatorColor,
        child: Column(
          children: [
            Image.asset(
              AppImages.welcomeImage,
              width: double.infinity,
              fit: BoxFit.cover,
              height: AppMediaQueryExtension(context).screenHeight / 1.68,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.welcome,
                    style: AppTextStyles.header48,
                  ),
                  Text(
                    AppStrings.welcome2,
                    style: AppTextStyles.header16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          LocalData.prefs.setBool('isFirstLaunch', true);
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'homeScreen', (context) => false);
                        },
                        child: const Text(
                          AppStrings.start,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
