import 'dart:async';
import 'package:sikka_wallet/data/network/apis/posts/post_api.dart';
import 'package:sikka_wallet/domain/entity/leaderboard/leaderboard.dart';
import 'package:sikka_wallet/domain/entity/news/news_feed.dart';
import 'package:sikka_wallet/domain/entity/wallet/conversion.dart';
import 'package:sikka_wallet/domain/entity/wallet/wallet.dart';
import 'package:sikka_wallet/domain/entity/wallet/wallet_conversion_request.dart';
import 'package:sikka_wallet/domain/repository/post/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  // data source object

  // api objects
  final ApiClient _postApi;

  // constructor
  PostRepositoryImpl(this._postApi);

  // Post: ---------------------------------------------------------------------
  @override
  Future<SikkaXNewsList> getPosts() async {
    return await _postApi.getPosts().then((postsList) {
      return postsList;
    }).catchError((error) => throw error);
  }

  // Post: ---------------------------------------------------------------------
  @override
  Future<LeaderBoardEntryList> getLeaderBoard() async {
    return await _postApi.getLeaderboard().then((leaderboardList) {
      return leaderboardList;
    }).catchError((error) => throw error);
  }

  @override
  Future<WalletData> getWalletBalance() async {
    return await _postApi.getWalletBalance().then((walletBalance) {
      return walletBalance;
    }).catchError((error) => throw error);
  }

  @override
  Future<WalletConversion> convertCurrency(WalletConversionRequest request) async {
    return await _postApi.convertCurrency(request).then((walletBalance) {
      return walletBalance;
    }).catchError((error) => throw error);
  }
}
