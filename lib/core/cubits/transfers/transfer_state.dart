import '../../models/player_transfer_detail.dart';

enum TransferStatus { initial, loading, loaded, error }

class TransferState {
  final TransferStatus status;
  final List<PlayerTransferDetail> transfers;
  final String errorMessage;
  final bool isSearchFocused;

  TransferState({
    this.status = TransferStatus.initial,
    this.transfers = const [],
    this.errorMessage = '',
    this.isSearchFocused = false,
  });

  TransferState copyWith({
    TransferStatus? status,
    List<PlayerTransferDetail>? transfers,
    String? errorMessage,
    bool? isSearchFocused,
  }) {
    return TransferState(
      status: status ?? this.status,
      transfers: transfers ?? this.transfers,
      errorMessage: errorMessage ?? this.errorMessage,
      isSearchFocused: isSearchFocused ?? this.isSearchFocused,
    );
  }
}
