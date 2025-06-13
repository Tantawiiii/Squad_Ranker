import 'package:app_b_804/app_resource/app_strings.dart';
import 'package:app_b_804/app_resource/app_text_styles.dart';
import 'package:app_b_804/core/extensions/app_size_extensions.dart';
import 'package:app_b_804/screens/leagues/widgets/leauges_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_resource/app_colors.dart';
import '../../core/cubits/leaugeCubit/leauge_cubit.dart';
import '../../core/cubits/leaugeCubit/leauge_state.dart';
import '../../widgets/app_bar.dart';

class LeaguesScreen extends StatelessWidget {
  const LeaguesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LeaugeCubit.leaugeCubit = context.watch<LeaugeCubit>();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(
            title: AppStrings.leagues,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
            child: Text(
              AppStrings.playersInTheQuizWill,
              textAlign: TextAlign.start,
              style: AppTextStyles.header16.copyWith(
                color: AppColors.buttonBackgroundColor,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<LeaugeCubit, LeaugeState>(
              bloc: LeaugeCubit.leaugeCubit,
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: AppMediaQueryExtension(context).screenWidth / 7,
                  ),
                  child: ListView.builder(
                      itemCount: state.leauges.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return LeaugesWidget(
                          checkOnTap: () {
                            LeaugeCubit.leaugeCubit!.sellectLeauge(index);
                          },
                          isNew: state.leauges[index].isNew,
                          openedTitle: state.leauges[index].isOpened
                              ? state.leauges[index].name
                              : null,
                          checkBoxType: state.leauges[index].isOpened
                              ? LeaugeCubit.leaugeCubit!.checkBoxIsClosed(index)
                                  ? CheckBox.checkBoxIsClosed
                                  : LeaugeCubit.leaugeCubit!
                                          .checkBoxIsSellected(index)
                                      ? CheckBox.checkBoxIsSellected
                                      : CheckBox.checkBoxIsNotSelleted
                              : null,
                          closedTitle: !state.leauges[index].isOpened
                              ? state.leauges[index].name
                              : null,
                          scored: !state.leauges[index].isOpened
                              ? state.leauges[index].score.toString()
                              : null,
                        );
                      }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
