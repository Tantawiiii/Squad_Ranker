import 'package:dio/dio.dart';

import '../models/player_model.dart';
import '../models/player_transfer_detail.dart';
import '../models/transfer_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://transfermarket.p.rapidapi.com/',
    headers: {
      'x-rapidapi-host': 'transfermarket.p.rapidapi.com',
      'x-rapidapi-key': '0a4b43d9f6mshc9e9d6270843362p1bd519jsnd1c97f754415',
    },
  ));


  Future<List<Map<String, dynamic>>> getQuizPlayer(String competitionId) async {
    try {
      final response = await _dio.get(
        'transfers/list',
        queryParameters: {'domain': 'de', 'competitionID': competitionId},
      );
      if (response.statusCode == 200) {
        return (response.data['player'] as List).cast<Map<String, dynamic>>();
      }
    } catch (e) {
      print('Error in getTransfers: $e');
    }
    return [];
  }

  Future<List<Player>> getPlayersDetailsBulk(List<Map<String, dynamic>> transfers) async {
    try {
      final playerIds = transfers
          .map((t) => int.parse(t['playerID'].toString()))
          .toList();

      final response = await getPlayersShortInfoByIds(playerIds);

      if (response != null && response['player'] != null) {
        final playersData = response['player'] as List<dynamic>;

        return List.generate(transfers.length, (index) {
          final transfer = transfers[index];
          final playerData = playersData.firstWhere(
                (p) => p['id'] == transfer['playerID'].toString(),
            orElse: () => null,
          );

          final marketValue = transfer['transferMarketValue']['value'] is int
              ? transfer['transferMarketValue']['value'] as int
              : int.tryParse(transfer['transferMarketValue']['value']?.toString() ?? '0') ?? 0;

          return playerData != null
              ? Player.fromShortInfoJson(playerData, marketValue)
              : Player(
            id: transfer['playerID'].toString(),
            name: 'Unknown Player',
            marketValue: marketValue,
            position: 'N/A',
            number: '?',
          );
        });
      }
    } catch (e) {
      print('Error in getPlayersDetailsBulk: $e');
    }

    return [];
  }

  Future<Player> getPlayerDetails(String playerId, int marketValue) async {
    try {
      final headerInfo = await getPlayerHeaderInfo(int.parse(playerId));
      if (headerInfo != null) {
        return Player(
          id: playerId,
          name: headerInfo['name'] ?? 'Unknown Player',
          marketValue: marketValue,
          position: headerInfo['position'],
          number: headerInfo['shirtNumber']?.toString(),
        );
      }
    } catch (e) {
      print('Error in getPlayerDetails: $e');
    }
    return Player(
      id: playerId,
    //  playerID: playerId,
      name: 'Unknown Player',
      marketValue: marketValue,
    );
  }


  Future<Map<String, dynamic>?> getPlayerHeaderInfo(int playerId) async {
    try {
      final response = await _dio.get(
        'players/get-header-info',
        queryParameters: {
          'id': playerId,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data;
      }
    } catch (e) {
      print('Error in getPlayerHeaderInfo: $e');
    }

    return null;
  }

  Future<Map<String, dynamic>?> getPlayerProfile(String playerId) async {
    try {
      final response = await _dio.get(
        'players/get-profile',
        queryParameters: {
          'id': int.parse(playerId),
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data;
      }
    } catch (e) {
      print('Error in get-profile: $e');
    }

    return null;
  }

  Future<List<Transfer>> fetchTransfersFromLeagues({
    required List<String> leagueIds,
    required int limit,
    required int offset,
  }) async {
    List<Transfer> allTransfers = [];

    for (String leagueId in leagueIds) {
      print(
          '🌐 API Call: competitionID=$leagueId, limit=$limit, offset=$offset');

      final response = await _dio.get('transfers/list', queryParameters: {
        'competitionID': leagueId,
        'limit': limit,
        'offset': offset,
        'domain': 'en',
      });

      if (response.statusCode == 200 && response.data['player'] != null) {
        final List data = response.data['player'];
        allTransfers.addAll(data.map((e) => Transfer.fromJson(e)));
        print(
            '✅ API Response: Found ${data.length} transfers for competition $leagueId');
      } else {
        print('⚠️ API Response: No data found for competition $leagueId');
      }
    }

    allTransfers.sort((a, b) => b.date.compareTo(a.date));
    return allTransfers;
  }

  Future<Response?> requestToServer(
      {required String url, Map<String, dynamic>? header}) async {
    final response = await _dio.get(url, queryParameters: header);
    if (response.statusCode == 200 && response.data['player'] != null) {
      return response;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getPlayersShortInfoByIds(List<int> playerIds) async {
    try {
      String idsString = playerIds.map((id) => id.toString()).join(',');

      final response = await _dio.get(
        'players/get-short-info',
        queryParameters: {'ids': idsString},
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data;
      }
    } catch (e) {
      print('Error in getPlayersShortInfoByIds: $e');
    }
    return null;
  }

  Future<List<PlayerTransferDetail>> getPlayerTransferHistory(
      String playerId) async {
    final response =
        await _dio.get('players/get-transfer-history', queryParameters: {
      'id': int.parse(playerId),
      'domain': 'en',
    });

    if (response.statusCode == 200 &&
        response.data['transferHistory'] != null) {
      final List data = response.data['transferHistory'];
      return data.map((e) => PlayerTransferDetail.fromJson(e)).toList();
    }

    return [];
  }
}
