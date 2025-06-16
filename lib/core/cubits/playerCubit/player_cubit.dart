import 'package:app_b_804/core/cubits/playerCubit/player_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/player_profile.dart';
import '../../models/player_transfer_detail.dart';
import '../../service/api_service.dart';

class PlayerProfileCubit extends Cubit<PlayerProfileState> {
  final ApiService apiService;

  PlayerProfileCubit(this.apiService) : super(PlayerProfileInitial());

  Future<void> fetchPlayerProfile(String playerId) async {
    emit(PlayerProfileLoading());
    try {
      final data = await apiService.getPlayerProfile(playerId);
      if (data != null) {
        final profile = PlayerProfile.fromJson(data);
        emit(PlayerProfileLoaded(profile));
      } else {
        emit(PlayerProfileError("No data found"));
      }
    } catch (e) {
      emit(PlayerProfileError(e.toString()));
    }
  }

  Future<void> getPlayerTransferHistory(String playerId) async {
    emit(PlayerProfileLoading());
    try {
      final List<PlayerTransferDetail> history =
      await apiService.getPlayerTransferHistory(playerId);
      emit(PlayerTransferHistoryLoaded(history));
    } catch (e) {
      emit(PlayerProfileError(e.toString()));
    }
  }
}

