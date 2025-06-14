import 'package:shared_preferences/shared_preferences.dart';

class SharedScoreHelper {
  static const String _highScoreKey = 'high_score';
  static const String _totalGamesPlayedKey = 'total_games_played';
  static const String _lastScoreKey = 'last_score';
  static const String _averageScoreKey = 'average_score';
  static const String _totalScoreKey = 'total_score';


  static SharedScoreHelper? _instance;
  static SharedScoreHelper get instance {
    _instance ??= SharedScoreHelper._internal();
    return _instance!;
  }

  SharedScoreHelper._internal();

  // Save high score
  Future<bool> saveHighScore(int score) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setInt(_highScoreKey, score);
    } catch (e) {
      print('Error saving high score: $e');
      return false;
    }
  }

  Future<int> getHighScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_highScoreKey) ?? 0;
    } catch (e) {
      print('Error getting high score: $e');
      return 0;
    }
  }
  Future<bool> saveLastScore(int score) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setInt(_lastScoreKey, score);
    } catch (e) {
      print('Error saving last score: $e');
      return false;
    }
  }


  Future<int> getLastScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_lastScoreKey) ?? 0;
    } catch (e) {
      print('Error getting last score: $e');
      return 0;
    }
  }


  Future<bool> saveTotalGamesPlayed(int totalGames) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setInt(_totalGamesPlayedKey, totalGames);
    } catch (e) {
      print('Error saving total games played: $e');
      return false;
    }
  }


  Future<int> getTotalGamesPlayed() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_totalGamesPlayedKey) ?? 0;
    } catch (e) {
      print('Error getting total games played: $e');
      return 0;
    }
  }

  // Save total score (sum of all scores)
  Future<bool> saveTotalScore(int totalScore) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setInt(_totalScoreKey, totalScore);
    } catch (e) {
      print('Error saving total score: $e');
      return false;
    }
  }

  Future<int> getTotalScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_totalScoreKey) ?? 0;
    } catch (e) {
      print('Error getting total score: $e');
      return 0;
    }
  }


  Future<double> calculateAndSaveAverageScore() async {
    try {
      final totalScore = await getTotalScore();
      final totalGames = await getTotalGamesPlayed();

      if (totalGames == 0) return 0.0;

      final average = totalScore / totalGames;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_averageScoreKey, average);

      return average;
    } catch (e) {
      print('Error calculating average score: $e');
      return 0.0;
    }
  }

  Future<double> getAverageScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(_averageScoreKey) ?? 0.0;
    } catch (e) {
      print('Error getting average score: $e');
      return 0.0;
    }
  }


  Future<Map<String, dynamic>> updateScoreAfterGame(int newScore) async {
    try {
      // Get current values
      final currentHighScore = await getHighScore();
      final currentTotalGames = await getTotalGamesPlayed();
      final currentTotalScore = await getTotalScore();

      // Calculate new values
      final newTotalGames = currentTotalGames + 1;
      final newTotalScore = currentTotalScore + newScore;
      final newHighScore = newScore > currentHighScore ? newScore : currentHighScore;

      // Save all values
      await Future.wait([
        saveLastScore(newScore),
        saveHighScore(newHighScore),
        saveTotalGamesPlayed(newTotalGames),
        saveTotalScore(newTotalScore),
      ]);


      final newAverageScore = await calculateAndSaveAverageScore();

      return {
        'lastScore': newScore,
        'highScore': newHighScore,
        'totalGamesPlayed': newTotalGames,
        'totalScore': newTotalScore,
        'averageScore': newAverageScore,
        'isNewHighScore': newScore > currentHighScore,
      };
    } catch (e) {
      print('Error updating score after game: $e');
      return {
        'lastScore': newScore,
        'highScore': newScore,
        'totalGamesPlayed': 1,
        'totalScore': newScore,
        'averageScore': newScore.toDouble(),
        'isNewHighScore': true,
      };
    }
  }


  Future<Map<String, dynamic>> getAllScoreStats() async {
    try {
      final results = await Future.wait([
        getLastScore(),
        getHighScore(),
        getTotalGamesPlayed(),
        getTotalScore(),
        getAverageScore(),
      ]);

      return {
        'lastScore': results[0] as int,
        'highScore': results[1] as int,
        'totalGamesPlayed': results[2] as int,
        'totalScore': results[3] as int,
        'averageScore': results[4] as double,
      };
    } catch (e) {
      print('Error getting all score stats: $e');
      return {
        'lastScore': 0,
        'highScore': 0,
        'totalGamesPlayed': 0,
        'totalScore': 0,
        'averageScore': 0.0,
      };
    }
  }

  // Reset all scores
  Future<bool> resetAllScores() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await Future.wait([
        prefs.remove(_highScoreKey),
        prefs.remove(_totalGamesPlayedKey),
        prefs.remove(_lastScoreKey),
        prefs.remove(_averageScoreKey),
        prefs.remove(_totalScoreKey),
      ]);
      return true;
    } catch (e) {
      print('Error resetting all scores: $e');
      return false;
    }
  }

  Future<bool> isFirstTimePlaying() async {
    try {
      final totalGames = await getTotalGamesPlayed();
      return totalGames == 0;
    } catch (e) {
      print('Error checking if first time playing: $e');
      return true;
    }
  }


  String formatScore(int score) {
    return score.toString().padLeft(2, '0');
  }

  String formatAverageScore(double average) {
    return average.toStringAsFixed(1);
  }
}