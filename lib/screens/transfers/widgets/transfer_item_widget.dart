import 'package:app_b_804/app_resource/app_images.dart';
import 'package:app_b_804/app_resource/app_text_styles.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app_resource/app_colors.dart';
import '../../../core/cubits/transfers/transfer_cubit.dart';
import '../../../core/extensions/app_size_extensions.dart';
import '../../../core/models/player_transfer_detail.dart';

class TransferCard extends StatelessWidget {
  final PlayerTransferDetail transfer;

  const TransferCard({super.key, required this.transfer});

  @override
  Widget build(BuildContext context) {

    return Bounce(
      onTap: (){
        print("fromCompetition: ${transfer.fromCompetition}" );
        Navigator.pushNamed(
          context,
          'playerDetails',
          arguments: transfer.playerID,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
        decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 52 / 852 * AppMediaQueryExtension(context).screenHeight,
              padding: const EdgeInsets.only(right: 12),
              decoration: const BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (transfer.countryImage.isNotEmpty)
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.network(
                        transfer.countryImage,
                        width: 32,
                        height: 32,
                        // fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      ),
                    )
                  else
                    const SizedBox(width: 24, height: 24),
                  Expanded(
                    child: Text(
                      transfer.playerName!,
                      style: AppTextStyles.header16.copyWith(fontSize: 14),
                    ),
                  ),
                  Text(
                    context.read<TransferCubit>().formatDate(transfer.date!),
                    style: AppTextStyles.header16.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Image.asset(
                    AppImages.fromWheretoIcon,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        transfer.newClubName.isNotEmpty
                            ? transfer.oldClubName
                            : 'Unknown Team',
                        style: AppTextStyles.header14,
                      ),
                      Text(
                        transfer.newClubName.isNotEmpty
                            ? transfer.newClubName
                            : 'Unknown Team',
                        style: AppTextStyles.header14,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    transfer.transferFeeValue.isEmpty ||
                            transfer.transferFeeValue == '?' ||
                            transfer.transferFeeValue == '-' ||
                            transfer.transferFeeValue == 'ablöse- frei'
                        ? '?'
                        : '€ ${transfer.transferFeeValue}M',
                    style: AppTextStyles.header14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
