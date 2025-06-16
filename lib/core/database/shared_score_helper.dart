import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _scoreKey = 'quiz_total_score';

  Future<int> getTotalScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_scoreKey) ?? 0;
  }

  Future<void> saveTotalScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_scoreKey, score);
  }
}