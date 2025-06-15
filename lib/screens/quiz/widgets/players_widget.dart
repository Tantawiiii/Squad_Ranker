import 'package:flutter/material.dart';

import '../../../app_resource/app_colors.dart';
import '../../../app_resource/app_text_styles.dart';

class PlayersWidget extends StatelessWidget {
  const PlayersWidget({
    super.key,
    required this.name,
    required this.number,
    required this.position,
    this.marginRight = 7,
    required this.choosenPlayer,
    this.onTap,
  });
  final String name;
  final String number;
  final String position;
  final double marginRight;
  final bool choosenPlayer;
  final VoidCallback? onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          right: marginRight,
        ),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: choosenPlayer
              ? AppColors.indecatorColor
              : AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.circular(
            13,
          ),
        ),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  'assets/images/shirt.png',
                  width: 60,
                ),
                Text(
                  number,
                  style: AppTextStyles.header20.copyWith(),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: AppTextStyles.header16.copyWith(),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              position,
              style: AppTextStyles.header16.copyWith(
                fontSize: 12,
                color: choosenPlayer ? AppColors.background : AppColors.lightGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
