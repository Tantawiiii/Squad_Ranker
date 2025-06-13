import 'package:app_b_804/core/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  static QuizCubit? quizCubit;
  ApiService apiService = ApiService();
  QuizCubit() : super(QuizState());

  void initQuiz() async {
    dynamic result = await apiService
        .requestToServer(url: 'players/get-header-info', header: {
      'id': 74842,
      'domain': 'en',
    });
  }
}
