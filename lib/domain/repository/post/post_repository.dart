import 'dart:async';

import 'package:sikka_wallet/domain/entity/leaderboard/leaderboard.dart';
import 'package:sikka_wallet/domain/entity/news/news_feed.dart';
import 'package:sikka_wallet/domain/entity/transaction/transaction.dart';
import 'package:sikka_wallet/domain/entity/wallet/conversion.dart';
import 'package:sikka_wallet/domain/entity/wallet/wallet.dart';
import 'package:sikka_wallet/domain/entity/wallet/wallet_conversion_request.dart';

abstract class PostRepository {
  Future<SikkaXNewsList> getPosts();

  Future<LeaderBoardEntryList> getLeaderBoard();

  Future<WalletData> getWalletBalance();

  Future<WalletConversion> convertCurrency(WalletConversionRequest request);

  Future<TransactionList> getTransactionHistory();
}
