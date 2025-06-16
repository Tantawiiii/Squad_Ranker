class HomeState {
  final bool isConnected;

  HomeState({this.isConnected = true});

  HomeState copyWith({bool? isConnected}) {
    return HomeState(
      isConnected: isConnected ?? this.isConnected,
    );
  }
}
