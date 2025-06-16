import 'package:flutter/material.dart';

import '../../../app_resource/app_colors.dart';
import '../../../app_resource/app_images.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'settingsScreen');
      },
      child: Container(
        width: 48,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.indecatorColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.asset(
          AppImages.settingsIcon,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
