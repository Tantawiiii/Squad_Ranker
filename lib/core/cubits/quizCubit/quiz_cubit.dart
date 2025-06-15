import 'dart:math';

import 'package:app_b_804/core/cubits/quizCubit/quiz_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_resource/competition_ids.dart';
import '../../database/shared_score_helper.dart';
import '../../models/player_model.dart';
import '../../service/api_service.dart';



class QuizCubit extends Cubit<QuizState> {
  final ApiService apiService;
  final SharedPreferencesService sharedPrefsService;
  int score = 0;
  List<Player> playersList = [];

  QuizCubit(this.apiService, this.sharedPrefsService) : super(QuizInitial()) {
    _loadScore();
  }

  Future<void> _loadScore() async {
    score = await sharedPrefsService.getTotalScore();
  }

  Future<void> _saveScore() async {
    await sharedPrefsService.saveTotalScore(score);
  }

  Future<void> initQuizWithShortInfo() async {
    emit(QuizLoading());
    try {
      final randomLeagueIndex = Random().nextInt(leagueToCompetitionId.length);
      final competitionId = leagueToCompetitionId.values.elementAt(randomLeagueIndex);

      final transfers = await apiService.getQuizPlayer(competitionId);
      final validTransfers = transfers
          .where((t) => t['transferMarketValue']?['value'] != null)
          .toList()
        ..shuffle();

      // Take first 5 transfers
      final selectedTransfers = validTransfers.take(5).toList();

      // Get all player details in one request
      playersList = await apiService.getPlayersDetailsBulk(selectedTransfers);

      if (playersList.length < 5) {
        emit(const QuizError('Could not fetch enough players'));
      } else {
        emit(QuizLoaded(players: playersList));
      }
    } catch (e) {
      emit(QuizError('Error loading quiz: $e'));
    }
  }

  void checkAnswers(List<Player?> selectedPlayers) {
    final originalPlayers = List<Player>.from(playersList);
    final sortedPlayers = List<Player>.from(originalPlayers)
      ..sort((a, b) => b.marketValue.compareTo(a.marketValue));

    int roundScore = 0;
    final results = <bool>[];

    for (int i = 0; i < selectedPlayers.length; i++) {
      final player = selectedPlayers[i];
      if (player == null) {
        results.add(false);
        continue;
      }

      if (i >= sortedPlayers.length) {
        results.add(false);
        continue;
      }

      final isCorrect = player.marketValue == sortedPlayers[i].marketValue;
      results.add(isCorrect);

      if (isCorrect) roundScore += 10;
    }

    score += roundScore;
    _saveScore();
    emit(QuizAnswersChecked(
      players: originalPlayers,
      results: results,
      roundScore: roundScore,
    ));
  }

  void startNewQuiz() {
    playersList.clear();
    emit(QuizInitial());
    initQuizWithShortInfo();
  }
}

