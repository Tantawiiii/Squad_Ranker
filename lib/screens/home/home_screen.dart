import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_resource/app_strings.dart';
import '../../core/cubits/quizCubit/quiz_cubit.dart';
import '../../core/database/database.dart';
import '../../widgets/app_bar.dart';
import 'widgets/coins_row.dart';
import 'widgets/settings_container.dart';
import 'widgets/start_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalScore = context.read<QuizCubit>().score;

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            leftPadding: 0,
            leftWidget: CoinsRow(
              coins: "$totalScore",
            ),
            rightWidget: const SettingsContainer(),
          ),
          StartContainer(
            leagueOntap: () {
              Navigator.pushNamed(context, 'leaguesScreen');
            },
            startOnTap: () {
              if (LocalData.prefs.getBool('firstTutorial') != null) {
                Navigator.pushNamed(context, 'quizScreen');
              }
              if (LocalData.prefs.getBool('firstTutorial') == null) {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'tutorialScreen', (context) => false);
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'transfersScreen');
                },
                child: const Text(
                  AppStrings.transfers,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
