import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sikka_wallet/core/data/network/dio/dio_client.dart';
import 'package:sikka_wallet/data/network/constants/endpoints.dart';
import 'package:sikka_wallet/data/network/rest_client.dart';
import 'package:sikka_wallet/domain/entity/auth/authentication_response.dart';
import 'package:sikka_wallet/domain/entity/leaderboard/leaderboard.dart';
import 'package:sikka_wallet/domain/entity/news/news_feed.dart';
import 'package:sikka_wallet/domain/entity/post/post_list.dart';
import 'package:sikka_wallet/domain/entity/wallet/conversion.dart';
import 'package:sikka_wallet/domain/entity/wallet/wallet.dart';
import 'package:sikka_wallet/domain/entity/wallet/wallet_conversion_request.dart';

class ApiClient {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  ApiClient(this._dioClient, this._restClient);

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

  Future<WalletData> getWalletBalance() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.wallet);
      return WalletData.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to load wallet balance: $e");
    }
  }

  Future<WalletConversion> convertCurrency(WalletConversionRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        Endpoints.convert, // Your API endpoint for login
        data: {"amount": request.amount, "conversionType": request.conversionType},
      );
      return WalletConversion.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null && e.response?.data is Map<String, dynamic>) {
        final errorMessage = e.response?.data['message'] ?? "Login failed";
        throw Exception(errorMessage);
      } else {
        throw Exception("Network error. Please try again.");
      }
    }
  }
}
