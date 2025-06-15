import 'package:app_b_804/app_resource/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_resource/app_colors.dart';
import '../../app_resource/app_strings.dart';
import '../../core/cubits/transfers/transfer_cubit.dart';
import '../../core/cubits/transfers/transfer_state.dart';
import '../../widgets/app_bar.dart';
import 'widgets/filter_bottom_sheet_widget.dart';
import 'widgets/load_more_widget.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/transfer_item_widget.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<TransferCubit>();
    if (!cubit.hasLoadedData) {
      cubit.loadInitialTransfers();
    }
    scrollController.addListener(() {
      final cubit = context.read<TransferCubit>();
      cubit.onScroll(
        scrollController.position.pixels,
        scrollController.position.maxScrollExtent,
      );
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransferCubit>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            CustomAppBar(
              title: 'Transfers',
              onBack: () {
                cubit.searchController.clear();
                Navigator.pop(context);
              },
            ),
            BlocBuilder<TransferCubit, TransferState>(
              builder: (context, state) {
                return SearchBarWidget(
                  controller: cubit.searchController,
                  focusNode: cubit.searchFocusNode,
                  isFocused: state.isSearchFocused,
                  onChanged: cubit.searchTransfersByName,
                  onClear: cubit.searchController.clear,
                  onTap: () {
                    final cubit = context.read<TransferCubit>();
                    final season = cubit.selectedSeason;
                    final safeSeason = season.isNotEmpty && season.length >= 4
                        ? season.substring(0, 4)
                        : '';

                    showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColors.background,
                      isScrollControlled: true,
                      builder: (_) => FilterBottomSheet(
                        selectedSeason: safeSeason,
                        selectedLeagues: cubit.selectedLeagues,
                        selectedClubName: cubit.selectedClubName,
                        onApply: (season, leagues, clubName) {
                          context.read<TransferCubit>().applyFilter(
                            season: season,
                            leagues: leagues,
                            clubName: clubName,
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  final state = context.watch<TransferCubit>().state;
                  final cubit = context.read<TransferCubit>();

                  if (state.status == TransferStatus.loading &&
                      state.transfers.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.indecatorColor,
                        color: AppColors.gray,
                        strokeAlign: 4,
                      ),
                    );
                  }

                  if (state.transfers.isEmpty) {
                    return Center(
                      child: Text(
                        cubit.isSearching
                            ? AppStrings.errorTransfer
                            : AppStrings.errorTransferTwo,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.header14,
                      ),
                    );
                  }

                  return Stack(
                    children: [
                      ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.only(bottom: 80, top: 10),
                        itemCount: state.transfers.length,
                        itemBuilder: (context, index) {
                          return TransferCard(transfer: state.transfers[index]);
                        },
                      ),
                      if (!cubit.isSearching) ...[
                        if (cubit.isLoadingMore)
                          const Positioned(
                            bottom: 30,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: AppColors.indecatorColor,
                                color: AppColors.gray,
                              ),
                            ),
                          )
                        else if (cubit.showLoadMore)
                          Positioned(
                            bottom: 30,
                            left: 16,
                            right: 16,
                            child: LoadMoreWidget(
                              onTap: () => cubit.loadMoreTransfers(),
                            ),
                          ),
                      ]
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}