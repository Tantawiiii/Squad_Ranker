import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/player_transfer_detail.dart';
import '../../service/api_service.dart';
import 'transfer_state.dart';
import '../../../app_resource/competition_ids.dart';

class TransferCubit extends Cubit<TransferState> {
  final ApiService apiService;
  final List<String> competitionIds;
  final List<PlayerTransferDetail> _transfers = [];
  String selectedSeason = '24/25';
  Set<String> selectedLeagues = {};
  List<String> selectedClubName = [];
  final int _limit = 20;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool _isSearching = false;
  int _currentLeagueIndex = 0;
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

  TransferCubit(this.apiService, this.competitionIds) : super(TransferState()) {
    searchController.addListener(() {
      searchTransfersByName(searchController.text);
    });

    searchFocusNode.addListener(() {
      emit(state.copyWith(isSearchFocused: searchFocusNode.hasFocus));
    });
  }

  bool _matchesSelectedLeagues(String? fromCompetition, String? toCompetition) {
    if (selectedLeagues.isEmpty) {
      return true;
    }


    Set<String> selectedCompetitionIds = {};
    for (String league in selectedLeagues) {
      String? competitionId = leagueToCompetitionId[league];
      if (competitionId != null) {
        selectedCompetitionIds.add(competitionId);
      }
    }

    bool matchesFrom = fromCompetition != null && selectedCompetitionIds.contains(fromCompetition);
    bool matchesTo = toCompetition != null && selectedCompetitionIds.contains(toCompetition);

    return matchesFrom || matchesTo;
  }


  List<String> _getFilteredCompetitionIds() {

    if (selectedLeagues.isEmpty) {
      return competitionIds;
    }

    List<String> filteredIds = [];
    for (String league in selectedLeagues) {
      String? competitionId = leagueToCompetitionId[league];
      if (competitionId != null && competitionIds.contains(competitionId)) {
        filteredIds.add(competitionId);
      }
    }

    return filteredIds.isNotEmpty ? filteredIds : competitionIds;
  }

  Future<void> closeTextFaild() {
    searchController.dispose();
    searchFocusNode.dispose();
    return super.close();
  }

  void loadInitialTransfers() {
    _currentLeagueIndex = 0;
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
    if (_isLoading || _currentLeagueIndex >= competitionIds.length) return;

    _isLoading = true;
    emit(state.copyWith(status: TransferStatus.loading, transfers: _transfers));

    try {
      while (_currentLeagueIndex < competitionIds.length) {
        final leagueId = competitionIds[_currentLeagueIndex];
        final rawTransfers = await apiService.fetchTransfersFromLeagues(
          leagueIds: [leagueId],
          limit: _limit,
          offset: _offset,
        );

        if (rawTransfers.isEmpty) {
          _currentLeagueIndex++;
          _offset = 0;
          continue;
        }

        _offset += _limit;

        for (final transfer in rawTransfers) {
          final history = await apiService.getPlayerTransferHistory(transfer.playerID);

          for (final detail in history) {
            final matchesSeason = selectedSeason.isEmpty || detail.season == selectedSeason;

            final matchesClub = selectedClubName.isEmpty ||
                selectedClubName.any((club) =>
                detail.newClubName.toLowerCase().contains(club.toLowerCase()) ||
                    detail.oldClubName.toLowerCase().contains(club.toLowerCase()));

            final matchesLeague = _matchesSelectedLeagues(detail.fromCompetition, detail.toCompetition);

            final shouldInclude = !_isSearching && matchesSeason && matchesClub && matchesLeague;

            if (shouldInclude) {
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
                fromCompetition: detail.fromCompetition,
                toCompetition: detail.toCompetition,
              ));
            }
          }
        }
        break;
      }

      _transfers.sort(
            (a, b) => _parseDate(b.date!).compareTo(_parseDate(a.date!)),
      );

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

  String formatDate(String dateString) {
    try {
      final parts = dateString.split('.');
      if (parts.length == 3) {
        final day = parts[0].padLeft(2, '0');
        final month = parts[1].padLeft(2, '0');
        final year = parts[2].substring(2);
        return '$day.$month.$year';
      }
    } catch (_) {}
    return dateString;
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
    required String season,
    required Set<String> leagues,
    required List<String> clubName,
  }) {
    if (season.isEmpty || season.contains('/')) {
      selectedSeason = '';
    } else {
      try {
        final start = season.substring(2);
        final end = (int.parse(season) + 1).toString().substring(2);
        selectedSeason = '$start/$end';
      } catch (e) {
        selectedSeason = '';
      }
    }

    selectedLeagues = leagues;
    selectedClubName = clubName;
    loadInitialTransfers();
  }
}