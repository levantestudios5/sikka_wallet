import 'dart:async';

import 'package:sikka_wallet/core/data/network/dio/dio_client.dart';
import 'package:sikka_wallet/data/network/constants/endpoints.dart';
import 'package:sikka_wallet/data/network/rest_client.dart';
import 'package:sikka_wallet/domain/entity/leaderboard/leaderboard.dart';
import 'package:sikka_wallet/domain/entity/news/news_feed.dart';
import 'package:sikka_wallet/domain/entity/post/post_list.dart';

class PostApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  PostApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<SikkaXNewsList> getPosts() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getPosts);
      return SikkaXNewsList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<LeaderBoardEntryList> getLeaderboard() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.getLeaderBoard);
      return LeaderBoardEntryList.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to load leaderboard: $e");
    }
  }

}
