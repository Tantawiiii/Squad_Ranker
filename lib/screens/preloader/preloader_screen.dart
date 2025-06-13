import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_resource/app_colors.dart';
import '../../core/cubits/homeCubit/home_cubit.dart';
import '../../core/cubits/homeCubit/home_state.dart';
import '../../core/database/database.dart';
import 'widgets/no_internet_widget.dart';

class PreloaderScreen extends StatefulWidget {
  const PreloaderScreen({super.key});

  @override
  State<PreloaderScreen> createState() => _PreloaderScreenState();
}

class _PreloaderScreenState extends State<PreloaderScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    Timer(const Duration(seconds: 3), () {
      if (LocalData.prefs.getBool('isFirstLaunch') != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, 'homeScreen', (context) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, 'welcomeScreen', (context) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        const Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors.indecatorColor,
            color: AppColors.gray,
            strokeAlign: 4,
          ),
        ),
        const Spacer(),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (!state.isConnected) {
              return NoInternetWidget(
                onTap: () {
                  context.read<HomeCubit>().checkConnectionManually();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const SizedBox(height: 24),
      ],
    ));
  }
}
