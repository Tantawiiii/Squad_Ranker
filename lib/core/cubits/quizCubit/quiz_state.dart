class QuizState {
  final List<Map<String, dynamic>> players;
  final int score;
  final bool isLoading;

  QuizState({
    this.players = const [],
    this.score = 0,
    this.isLoading = false,
  });
}
