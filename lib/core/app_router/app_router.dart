import 'package:app_b_804/screens/player_details/player_details_screen.dart';
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
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const PreloaderScreen());
      case 'welcomeScreen':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case 'homeScreen':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case 'settingsScreen':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case 'transfersScreen':
        return MaterialPageRoute(builder: (_) => const TransferScreen());
      case 'leaguesScreen':
        return MaterialPageRoute(builder: (_) => const LeaguesScreen());
      case 'quizScreen':
        return MaterialPageRoute(builder: (_) => const QuizScreen());
      case 'tutorialScreen':
        return MaterialPageRoute(builder: (_) => const TutorialScreen());
      case 'playerDetails':
        final playerId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => PlayerDetailsScreen(playerId: playerId),
        );
    }
    return null;
  }
}

