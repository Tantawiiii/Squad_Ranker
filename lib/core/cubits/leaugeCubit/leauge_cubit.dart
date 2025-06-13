import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database.dart';
import '../../models/league_model.dart';
import 'leauge_state.dart';

class LeaugeCubit extends Cubit<LeaugeState> {
  static LeaugeCubit? leaugeCubit;
  LeaugeCubit() : super(LeaugeState()) {
    initLeauges();
  }
  void initLeauges() {
    List<Map<String, dynamic>> leaugeDataFromLocal = [];
    if (LocalData.prefs.getString('leauges') != null) {
      leaugeDataFromLocal = jsonDecode(LocalData.prefs.getString('leauges')!);
    }
    List<LeagueModel> leaugesResult = [];
    for (Map<String, dynamic> value in leaugeDataFromLocal.isNotEmpty
        ? leaugeDataFromLocal
        : LeaugeState.leaguesStatic) {
      leaugesResult.add(LeagueModel.fromJson(value));
    }
    emit(state.copyWith(getleauges: leaugesResult));
  }

  bool checkBoxIsSellected(int index) {
    return state.sellectedLeauges.any((item) => item['index'] == index);
  }

  bool checkBoxIsClosed(int index) {
    bool result = false;
    for (Map sellectetLeaugeMap in state.sellectedLeauges) {
      if (sellectetLeaugeMap['index'] == index) {
        if (state.sellectedLeauges.length <= 2) {
          result = true;
        }
      }
    }
    return result;
  }

  void sellectLeauge(int sellectedCeckboxIndex) {
    if (checkBoxIsClosed(sellectedCeckboxIndex)) return;
    List<Map<String, dynamic>> result = [];
    for (Map<String, dynamic> value in state.sellectedLeauges) {
      result.add(value);
    }
    if (checkBoxIsSellected(sellectedCeckboxIndex)) {
      result.removeAt(sellectedCeckboxIndex);
      emit(state.copyWith(getsellectedLeauges: result));
      return;
    }
    result.add(LeaugeState.leaguesStatic[sellectedCeckboxIndex]);
    emit(state.copyWith(getsellectedLeauges: result));
  }
}
