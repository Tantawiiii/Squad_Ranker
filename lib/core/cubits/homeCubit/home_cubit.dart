import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final InternetConnectionChecker connectionChecker =
      InternetConnectionChecker.createInstance();

  HomeCubit() : super(HomeState()) {
    _startListeningConnection();
  }

  void _startListeningConnection() {
    connectionChecker.onStatusChange.listen((status) {
      final isConnected = status == InternetConnectionStatus.connected;

      emit(state.copyWith(isConnected: isConnected));
    });
  }

  Future<void> checkConnectionManually() async {
    final result = await connectionChecker.hasConnection;
    emit(state.copyWith(isConnected: result));
  }
}
