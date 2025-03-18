import 'dart:async';

import 'package:sikka_wallet/domain/entity/news/news_feed.dart';

abstract class PostRepository {
  Future<SikkaXNewsList>  getPosts();

}
