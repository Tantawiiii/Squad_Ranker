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

  Future<List<PlayerTransferDetail>> getPlayerTransferHistory(
      String playerId) async {
    final response =
        await _dio.get('players/get-transfer-history', queryParameters: {
      'id': playerId,
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
