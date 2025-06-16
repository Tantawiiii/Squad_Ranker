import '../../models/player_profile.dart';
import '../../models/player_transfer_detail.dart';

abstract class PlayerProfileState {}

class PlayerProfileInitial extends PlayerProfileState {}

class PlayerProfileLoading extends PlayerProfileState {}

class PlayerProfileLoaded extends PlayerProfileState {
  final PlayerProfile profile;
  PlayerProfileLoaded(this.profile);
}

class PlayerTransferHistoryLoaded extends PlayerProfileState {
  final List<PlayerTransferDetail> history;
  PlayerTransferHistoryLoaded(this.history);
}

class PlayerProfileError extends PlayerProfileState {
  final String message;
  PlayerProfileError(this.message);
}
