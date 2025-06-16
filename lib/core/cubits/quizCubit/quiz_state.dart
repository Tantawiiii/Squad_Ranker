import 'package:equatable/equatable.dart';

import '../../models/player_model.dart';

abstract class QuizState extends Equatable {
  const QuizState();
  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Player> players;
  const QuizLoaded({required this.players});
  @override
  List<Object> get props => [players];
}

class QuizError extends QuizState {
  final String message;
  const QuizError(this.message);
  @override
  List<Object> get props => [message];
}

class QuizAnswersChecked extends QuizState {
  final List<Player> players;
  final List<bool> results;
  final int roundScore;
  const QuizAnswersChecked({
    required this.players,
    required this.results,
    required this.roundScore,
  });
  @override
  List<Object> get props => [players, results, roundScore];
}