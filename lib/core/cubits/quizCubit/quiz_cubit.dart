import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../service/api_service.dart';
import '../../models/player_short_info.dart';
import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  static QuizCubit? quizCubit;
  final ApiService apiService = ApiService();

  List<Map<String, dynamic>> playersList = [];
  int score = 0;

  int leagueId = 764; // Default League: Premier League
  int seasonId = 2023; // Default Season

  QuizCubit() : super(QuizState());

  void setLeagueAndSeason(int newLeagueId, int newSeasonId) {
    leagueId = newLeagueId;
    seasonId = newSeasonId;
  }

  void initQuiz() async {
    emit(QuizState(isLoading: true));

    dynamic result = await apiService.requestToServer(
      url: 'players/list-by-league',
      header: {
        'leagueId': leagueId,
        'seasonId': seasonId,
      },
    );

    if (result != null && result['players'] != null) {
      List<dynamic> players = result['players'];

      players = players.where((p) => p['player']['marketValue'] != null).toList();

      if (players.length >= 5) {
        players.shuffle(Random());

        playersList = players.take(5).map((p) {
          return {
            'name': p['player']['name'],
            'price': p['player']['marketValue'].toString(),
            'number': Random().nextInt(99).toString(),
          };
        }).toList();
        emit(QuizState(players: playersList, isLoading: false));
      } else {
        emit(QuizState(players: [], isLoading: false));
      }
    } else {
      emit(QuizState(players: [], isLoading: false));
    }
  }

  void initQuizWithShortInfo() async {
    emit(QuizState(isLoading: true));


    List<int> availablePlayerIds = [
      74842, 255755, 45660, 39381, 157501, 8198, 3322, 67, 28003, 134,
      40, 31, 148, 515, 3366, 239, 3370, 7763, 7902, 8980, 9576, 15358,
      22, 76, 85, 88, 103, 105, 108, 126, 131, 133, 135, 138, 149, 155,
      162, 178, 181, 191, 200, 210, 225, 227, 233, 234, 241, 246, 247,
      253, 259, 262, 271, 276, 278, 279, 282, 284, 285, 292, 294, 295
    ];

    Random random = Random();
    List<Map<String, dynamic>> tempList = [];

    try {

      List<int> selectedIds = [];
      while (selectedIds.length < 5 && availablePlayerIds.isNotEmpty) {
        int randomIndex = random.nextInt(availablePlayerIds.length);
        int selectedId = availablePlayerIds[randomIndex];
        selectedIds.add(selectedId);
        availablePlayerIds.removeAt(randomIndex);
      }

      Map<String, dynamic>? result = await apiService.getPlayersShortInfoByIds(selectedIds);

      if (result != null) {
        PlayerShortInfoResponse response = PlayerShortInfoResponse.fromJson(result);

        List<PlayerShortInfo> validPlayers = response.players
            .where((player) => player.marketValue != null)
            .toList();


        if (validPlayers.length < 5) {
          print('Warning: Only ${validPlayers.length} valid players found');
        }


        for (PlayerShortInfo player in validPlayers.take(5)) {
          tempList.add({
            'name': player.name,
            'price': player.marketValueString,
            'number': random.nextInt(99).toString(),
            'position': player.positionName,
            'image': player.image,
            'id': player.id,
          });
        }

        playersList = tempList;
        emit(QuizState(players: playersList, isLoading: false));
      } else {
        emit(QuizState(players: [], isLoading: false));
      }
    } catch (e) {
      print('Error in initQuizWithShortInfo: $e');
      emit(QuizState(players: [], isLoading: false));
    }
  }

  void initQuizWithHeaderInfo() async {
    emit(QuizState(isLoading: true));

    List<Map<String, dynamic>> tempList = [];
    int minId = 1;
    int maxId = 80000;
    Random random = Random();

    for (int i = 0; i < 5; i++) {
      int playerId = minId + random.nextInt(maxId - minId);

      dynamic result = await apiService.getPlayerHeaderInfo(playerId);

      if (result != null && result['data'] != null && result['data']['player'] != null) {
        var playerData = result['data']['player'];
        var marketValue = playerData['marketValue']?['value'] ?? 0;

        tempList.add({
          'name': playerData['name'] ?? 'Unknown',
          'price': marketValue.toString(),
          'number': Random().nextInt(99).toString(),
        });
      }
    }

    playersList = tempList;
    emit(QuizState(players: playersList, isLoading: false));
  }

  int parsePrice(dynamic price) {
    if (price == null) return 0;
    if (price is int) return price;
    if (price is String) return int.tryParse(price) ?? 0;
    return 0;
  }

  void checkAnswers(List<Map<String, dynamic>> userAnswers) {
    score = 0;

    for (int i = 0; i < playersList.length; i++) {
      if (i < userAnswers.length) {
        int userPrice = parsePrice(userAnswers[i]['price']);
        int correctPrice = parsePrice(playersList[i]['price']);

        if (userPrice == correctPrice) {
          score += 10;
        }
      }
    }

    emit(QuizState(players: playersList, score: score, isLoading: false));
  }

  void newQuiz() {
    score = 0;
    initQuizWithShortInfo();
  }
}