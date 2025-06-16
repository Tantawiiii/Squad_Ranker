import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app_resource/competition_ids.dart';
import '../../models/player_transfer_detail.dart';
import '../../service/api_service.dart';
import 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  final ApiService apiService;
  final List<String> allCompetitionIds;
  Set<String> selectedCompetitionIds = {};
  List<PlayerTransferDetail> _transfers = [];
  Set<String> selectedSeasons = {};
  Set<String> selectedLeagues = {};
  List<String> selectedClubName = [];
  final int _limit = 20;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool _isSearching = false;
  int _currentCompetitionIndex = 0;
  int _offset = 0;
  bool _hasMore = true;
  bool _showLoadMore = false;
  bool _isLoading = false;
  bool _isLoadingMore = false;

  bool get isSearchFocused => searchFocusNode.hasFocus;
  bool get isSearching => _isSearching;
  bool get hasLoadedData => _transfers.isNotEmpty;
  bool get showLoadMore => _showLoadMore;
  bool get isLoadingMore => _isLoadingMore;

  TransferCubit(this.apiService, this.allCompetitionIds) : super(TransferState()) {
    selectedCompetitionIds = allCompetitionIds.toSet();

    searchController.addListener(() {
      searchTransfersByName(searchController.text);
    });

    searchFocusNode.addListener(() {
      emit(state.copyWith(isSearchFocused: searchFocusNode.hasFocus));
    });
  }

  @override
  Future<void> close() {
    searchController.dispose();
    searchFocusNode.dispose();
    return super.close();
  }

  void loadInitialTransfers() {
    _currentCompetitionIndex = 0;
    _offset = 0;
    _hasMore = true;
    _showLoadMore = false;
    _transfers.clear();
    _loadTransfers();
  }

  void enableLoadMoreButton() {
    if (_hasMore && !_isLoading && !_showLoadMore && !_isLoadingMore) {
      _showLoadMore = true;
      emit(state.copyWith(transfers: _transfers));
    }
  }

  void loadMoreTransfers() {
    if (_hasMore && !_isLoading && !_isLoadingMore) {
      _showLoadMore = false;
      _isLoadingMore = true;
      _loadTransfers();
    }
  }

  Future<void> _loadTransfers() async {
    if (_isLoading || _currentCompetitionIndex >= selectedCompetitionIds.length) {
      return;
    }

    _isLoading = true;
    emit(state.copyWith(status: TransferStatus.loading, transfers: _transfers));

    try {
      final competitionIdsList = selectedCompetitionIds.toList();

      while (_currentCompetitionIndex < competitionIdsList.length) {
        final competitionId = competitionIdsList[_currentCompetitionIndex];

        final rawTransfers = await apiService.fetchTransfersFromLeagues(
          leagueIds: [competitionId],
          limit: _limit,
          offset: _offset,
        );

        if (rawTransfers.isEmpty) {
          _currentCompetitionIndex++;
          _offset = 0;
          continue;
        }

        _offset += _limit;

        for (final transfer in rawTransfers) {
          final history = await apiService.getPlayerTransferHistory(transfer.playerID);

          for (final detail in history) {
            // Filter by seasons
            if (selectedSeasons.isNotEmpty && !selectedSeasons.contains(detail.season)) {
              continue;
            }

            // Filter by club name
            if (selectedClubName.isNotEmpty &&
                !selectedClubName.any((club) =>
                detail.newClubName.toLowerCase().contains(club.toLowerCase()) ||
                    detail.oldClubName.toLowerCase().contains(club.toLowerCase()))) {
              continue;
            }

            _transfers.add(PlayerTransferDetail(
              playerID: detail.playerID,
              newClubCountryImage: detail.newClubCountryImage,
              oldClubName: detail.oldClubName,
              newClubName: detail.newClubName,
              transferFeeValue: detail.transferFeeValue.isNotEmpty
                  ? detail.transferFeeValue
                  : '?',
              transferFeeCurrency: detail.transferFeeCurrency,
              playerName: detail.playerName,
              countryImage: detail.countryImage,
              date: detail.date,
              season: detail.season,
            ));
          }
        }

        _currentCompetitionIndex++;
        break;
      }

      _transfers.sort((a, b) => _parseDate(b.date!).compareTo(_parseDate(a.date!)));

      emit(state.copyWith(
        status: TransferStatus.loaded,
        transfers: _isSearching ? state.transfers : _transfers,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TransferStatus.error,
        errorMessage: e.toString(),
      ));
    } finally {
      _isLoading = false;
      _isLoadingMore = false;
      if (_currentCompetitionIndex >= selectedCompetitionIds.length) {
        _hasMore = false;
      }
    }
  }

  void onScroll(double pixels, double maxScrollExtent) {
    if (pixels >= maxScrollExtent - 50 && !_showLoadMore && !_isLoadingMore) {
      enableLoadMoreButton();
    }
  }

  void searchTransfersByName(String query) {
    _isSearching = query.isNotEmpty;

    if (!_isSearching) {
      emit(state.copyWith(transfers: _transfers, status: TransferStatus.loaded));
      return;
    }

    final filtered = _transfers
        .where((t) =>
    t.playerName?.toLowerCase().contains(query.toLowerCase()) ?? false)
        .toList();

    emit(state.copyWith(transfers: filtered, status: TransferStatus.loaded));
  }

  DateTime _parseDate(String dateStr) {
    try {
      final parts = dateStr.split('.');
      if (parts.length != 3) return DateTime(2022);
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    } catch (_) {
      return DateTime(2022);
    }
  }

  void applyFilter({
    required Set<String> seasons,
    required Set<String> leagues,
    required List<String> clubName,
  }) {
    // Convert seasons to the format you need (e.g., "22/23")
    selectedSeasons = seasons.map((season) {
      if (season.isEmpty) return '';
      return '${season.substring(2)}/${(int.parse(season) + 1).toString().substring(2)}';
    }).where((s) => s.isNotEmpty).toSet();

    selectedCompetitionIds = leagues.isEmpty
        ? allCompetitionIds.toSet()
        : leagues.map((name) => leagueToCompetitionId[name] ?? '').where((id) => id.isNotEmpty).toSet();

    selectedLeagues = leagues;
    selectedClubName = clubName;

    loadInitialTransfers();
  }
}