import 'package:flutter/material.dart';

import '../../screens/home/home_screen.dart';
import '../../screens/leagues/leagues_screen.dart';
import '../../screens/preloader/preloader_screen.dart';
import '../../screens/quiz/quiz_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/transfers/transfers_screen.dart';
import '../../screens/tutorial/tutorial_screen.dart';
import '../../screens/welcome/welcome_screen.dart';

class AppRoute {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const PreloaderScreen(),
    'welcomeScreen': (context) => const WelcomeScreen(),
    'homeScreen': (context) => const HomeScreen(),
    'settingsScreen': (context) => const SettingsScreen(),
    'transfersScreen': (context) => const TransferScreen(),
    'leaguesScreen': (context) => const LeaguesScreen(),
    'quizScreen': (context) => const QuizScreen(),
    'tutorialScreen': (context) => const TutorialScreen(),
  };
}
