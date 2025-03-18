import 'dart:async';

import 'package:sikka_wallet/domain/entity/leaderboard/leaderboard.dart';
import 'package:sikka_wallet/domain/entity/news/news_feed.dart';

abstract class PostRepository {
  Future<SikkaXNewsList>  getPosts();
  Future<LeaderBoardEntryList>  getLeaderBoard();

}
