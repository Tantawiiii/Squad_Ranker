import 'package:app_b_804/screens/player_details/widget/transfer_item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app_resource/app_colors.dart';
import '../../app_resource/app_images.dart';
import '../../app_resource/app_text_styles.dart';
import '../../core/cubits/playerCubit/player_cubit.dart';
import '../../core/cubits/playerCubit/player_state.dart';
import '../../core/models/player_profile.dart';
import '../../core/models/player_transfer_detail.dart';
import '../../core/service/api_service.dart';
import '../../widgets/app_bar.dart';


class PlayerDetailsScreen extends StatefulWidget {
  final String playerId;

  const PlayerDetailsScreen({super.key, required this.playerId});

  @override
  State<PlayerDetailsScreen> createState() => _PlayerDetailsScreenState();
}

class _PlayerDetailsScreenState extends State<PlayerDetailsScreen> {
  PlayerProfile? playerProfile;
  List<PlayerTransferDetail>? transferHistory;
  bool isProfileLoading = true;
  bool isTransferLoading = true;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = PlayerProfileCubit(ApiService());
        cubit.fetchPlayerProfile(widget.playerId);
        cubit.getPlayerTransferHistory(widget.playerId);
        return cubit;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            title: 'Player Info',
            onBack: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocListener<PlayerProfileCubit, PlayerProfileState>(
          listener: (context, state) {
            print('Current state: ${state.runtimeType}');

            if (state is PlayerProfileLoaded) {
              setState(() {
                playerProfile = state.profile;
                isProfileLoading = false;
                errorMessage = null;
              });
            } else if (state is PlayerTransferHistoryLoaded) {
              setState(() {
                transferHistory = state.history;
                isTransferLoading = false;
                errorMessage = null;
              });
            } else if (state is PlayerProfileError) {
              setState(() {
                errorMessage = state.message;
                isProfileLoading = false;
                isTransferLoading = false;
              });
            } else if (state is PlayerProfileLoading) {
              setState(() {
                isProfileLoading = true;
                isTransferLoading = true;
                errorMessage = null;
              });
            }
          },
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: $errorMessage',
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<PlayerProfileCubit>().fetchPlayerProfile(widget.playerId);
                context.read<PlayerProfileCubit>().getPlayerTransferHistory(widget.playerId);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (isProfileLoading) {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.indecatorColor,
          color: AppColors.gray,
          strokeAlign: 4,
        ),
      );
    }


    if (playerProfile != null) {
      final profile = playerProfile!;
      final List<Map<String, String>> items = [
        {'title': 'Position:', 'value': profile.playerMainPosition ?? 'N/A'},
        {'title': 'Country:', 'value': profile.country ?? 'N/A'},
        {'title': 'Age:', 'value': profile.age ?? 'N/A'},
        {'title': 'Agent:', 'value': profile.agent ?? 'N/A'},
        {'title': 'Current Club:', 'value': profile.club ?? 'N/A'},
        {'title': 'Contract Expires:', 'value': profile.contractExpiryDate ?? 'N/A'},
      ];

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const SizedBox(height: 32),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.tShirtNum,
                      height: 96,
                      width: 96,
                    ),
                    Text(
                      profile.playerShirtNumber ?? "0",
                      style: AppTextStyles.header20.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  profile.playerName ?? "N/A",
                  style: AppTextStyles.header24.copyWith(
                    color: AppColors.buttonBackgroundColor,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 44,
                  width: 143,
                  decoration: BoxDecoration(
                    color: AppColors.indecatorColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        profile.marketValue ?? "N/A",
                        style: AppTextStyles.header20.copyWith(color: AppColors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        profile.marketValueCurrency ?? "N/A",
                        style: AppTextStyles.header20.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 6,
                    childAspectRatio: 125 / 75,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            items[index]['title']!,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.header14.copyWith(color: AppColors.hinitText),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            items[index]['value']!,
                            style: AppTextStyles.header14.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Transfer History",
                style: AppTextStyles.header14.copyWith(color: AppColors.black),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _buildTransferHistory(),
          ),
        ],
      );
    }

    // Fallback
    return const Center(
      child: Text(
        'Something went wrong. Please try again.',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  Widget _buildTransferHistory() {
    if (isTransferLoading) {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.indecatorColor,
          color: AppColors.gray,
          strokeAlign: 4,
        ),
      );
    }

    if (transferHistory == null || transferHistory!.isEmpty) {
      return const Center(
        child: Text(
          'No transfer history available',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: transferHistory!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TransferCardDetails(transfer: transferHistory![index]),
        );
      },
    );
  }
}