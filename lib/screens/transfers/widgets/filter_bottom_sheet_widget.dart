import 'package:app_b_804/app_resource/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../../app_resource/app_colors.dart';
import '../../../app_resource/competition_ids.dart';

class FilterBottomSheet extends StatefulWidget {
  final Set<String> selectedSeasons;
  final Set<String> selectedLeagues;
  final List<String> selectedClubName;
  final Function(Set<String> seasons, Set<String> leagues, List<String> clubName)
  onApply;

  const FilterBottomSheet({
    required this.selectedSeasons,
    required this.selectedLeagues,
    required this.selectedClubName,
    required this.onApply,
    super.key,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Set<String> _seasons;
  late Set<String> _leagues;
  late List<String> _selectedClubNames;

  final List<String> seasons = ['2022', '2023', '2024', '2025'];
  final List<String> leagues = leagueToCompetitionId.keys.toList();

  @override
  void initState() {
    super.initState();
    _seasons = Set.from(widget.selectedSeasons);
    _leagues = Set.from(widget.selectedLeagues);
    _selectedClubNames = List.from(widget.selectedClubName);
  }

  void _toggleSeason(String season) {
    setState(() {
      if (_seasons.contains(season)) {
        _seasons.remove(season);
      } else {
        _seasons.add(season);
      }
    });
  }

  void _toggleLeague(String league) {
    setState(() {
      if (_leagues.contains(league)) {
        _leagues.remove(league);
      } else {
        _leagues.add(league);
      }
    });
  }

  void _toggleClubName() {
    setState(() {
      if (_selectedClubNames.contains('Club Name')) {
        _selectedClubNames.remove('Club Name');
      } else {
        _selectedClubNames.add('Club Name');
      }
    });
  }

  void _clearAllFilters() {
    setState(() {
      _seasons.clear();
      _leagues.clear();
      _selectedClubNames.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool clubSelected = _selectedClubNames.contains('Club Name');

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: AppTextStyles.header17,
                ),
              ),
              Text(
                "Filter",
                style: AppTextStyles.header16.copyWith(color: AppColors.purple),
              ),
              GestureDetector(
                onTap: () {
                  widget.onApply(_seasons, _leagues, _selectedClubNames);
                  Navigator.pop(context);
                },
                child: Text(
                  "Done",
                  style: AppTextStyles.header17,
                ),
              ),
            ],
          ),
          const Divider(
            color: AppColors.dividerColor,
          ),

          if (_seasons.isNotEmpty || _leagues.isNotEmpty || _selectedClubNames.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: GestureDetector(
                onTap: _clearAllFilters,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.lightGray.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Clear All Filters",
                    style: AppTextStyles.header14.copyWith(
                      fontSize: 12,
                      color: AppColors.buttonBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 8),
            child: Row(
              children: [
                Text(
                  "Seasons",
                  style: AppTextStyles.header14,
                ),
                if (_seasons.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.buttonBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${_seasons.length}',
                      style: AppTextStyles.header14.copyWith(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Wrap(
            spacing: 8,
            children: seasons.map((season) {
              final isSelected = _seasons.contains(season);
              return GestureDetector(
                onTap: () => _toggleSeason(season),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.buttonBackgroundColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.lightGray, width: 2),
                  ),
                  child: Text(
                    season,
                    style: AppTextStyles.header14.copyWith(
                      fontSize: 12,
                      color: isSelected
                          ? AppColors.background
                          : AppColors.buttonBackgroundColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 8),
            child: Row(
              children: [
                Text(
                  "Leagues",
                  style: AppTextStyles.header14,
                ),
                if (_leagues.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.buttonBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${_leagues.length}',
                      style: AppTextStyles.header14.copyWith(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...leagues.map((league) {
                    final isSelected = _leagues.contains(league);
                    return GestureDetector(
                      onTap: () => _toggleLeague(league),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.buttonBackgroundColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.lightGray, width: 2),
                        ),
                        child: Text(
                          league,
                          style: AppTextStyles.header14.copyWith(
                            fontSize: 12,
                            color: isSelected
                                ? AppColors.background
                                : AppColors.buttonBackgroundColor,
                          ),
                        ),
                      ),
                    );
                  }),
                  GestureDetector(
                    onTap: _toggleClubName,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: clubSelected
                            ? AppColors.buttonBackgroundColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.lightGray, width: 2),
                      ),
                      child: Text(
                        'Club Name',
                        style: AppTextStyles.header14.copyWith(
                          fontSize: 12,
                          color: clubSelected
                              ? AppColors.background
                              : AppColors.buttonBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}