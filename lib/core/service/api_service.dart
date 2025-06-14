import 'package:dio/dio.dart';

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
      final response = await _dio.get('transfers/list', queryParameters: {
        'competitionID': leagueId,
        'limit': limit,
        'offset': offset,
        'domain': 'en',
      });

      if (response.statusCode == 200 && response.data['player'] != null) {
        final List data = response.data['player'];
        allTransfers.addAll(data.map((e) => Transfer.fromJson(e)));
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
        queryParameters: {
          'ids': idsString,
        },
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
