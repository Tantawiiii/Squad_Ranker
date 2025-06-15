import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_resource/app_theme.dart';
import 'app_resource/competition_ids.dart';
import 'core/app_router/app_router.dart';
import 'core/cubits/homeCubit/home_cubit.dart';
import 'core/cubits/leaugeCubit/leauge_cubit.dart';
import 'core/cubits/quizCubit/quiz_cubit.dart';
import 'core/cubits/settingsCubit/settings_cubit.dart';
import 'core/cubits/transfers/transfer_cubit.dart';
import 'core/database/shared_score_helper.dart';
import 'core/service/api_service.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (BuildContext context) => SettingsCubit(),
        ),
        BlocProvider<TransferCubit>(
            create: (BuildContext context) =>
                TransferCubit(ApiService(), leagueToCompetitionId.values.toList())),
        BlocProvider<LeaugeCubit>(
          create: (BuildContext context) => LeaugeCubit(),
        ),
        BlocProvider<QuizCubit>(
          create: (BuildContext context) => QuizCubit(ApiService(),   SharedPreferencesService(),),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        onGenerateRoute: AppRoute.onGenerateRoute,
        initialRoute: '/',
      ),
    );
  }
}
