import 'package:app_b_804/app_resource/app_images.dart';
import 'package:app_b_804/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_resource/app_strings.dart';
import '../../core/cubits/settingsCubit/settings_cubit.dart';
import '../../core/extensions/app_size_extensions.dart';
import 'widgets/settings_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: AppStrings.settings,
          ),
          SizedBox(
            height: 44 / 852 * AppMediaQueryExtension(context).screenHeight,
          ),
          SettingsRow(
            title: 'Notifications',
            onTap: () {
              context.read<SettingsCubit>().requestNotificationPermissions();
            },
          ),
          SettingsRow(
            title: 'Rate us',
            onTap: () {
              context.read<SettingsCubit>().launchPrivacyPolicy();
            },
          ),
          SettingsRow(
            title: 'Share App',
            onTap: () {
              context.read<SettingsCubit>().shareApp();
            },
          ),
          SettingsRow(
            title: 'Privacy policy',
            onTap: () {
              context.read<SettingsCubit>().launchPrivacyPolicy();
            },
          ),
          SizedBox(
              height: 120 / 852 * AppMediaQueryExtension(context).screenHeight),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              AppImages.footballBall,
              height: 230 / 852 * AppMediaQueryExtension(context).screenHeight,
            ),
          ),
        ],
      ),
    );
  }
}
