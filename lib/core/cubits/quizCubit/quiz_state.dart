class QuizState {
  final bool isConnected;

  QuizState({this.isConnected = true});

  QuizState copyWith({bool? isConnected}) {
    return QuizState(
      isConnected: isConnected ?? this.isConnected,
    );
  }
}
