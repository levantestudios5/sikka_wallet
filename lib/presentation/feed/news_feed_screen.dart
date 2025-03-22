import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/core/widgets/progress_indicator_widget.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/domain/entity/news/news_feed.dart';
import 'package:sikka_wallet/presentation/post/store/post_store.dart';
import 'package:sikka_wallet/utils/device/device_utils.dart';

import '../../constants/app_theme.dart';

class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  final PostStore postStore = getIt<PostStore>();

  @override
  void initState() {
    super.initState();
    postStore.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFA455F8),
        body: Observer(builder: (context) {
          postStore.postList?.posts;
          return postStore.loading
              ? Center(child: CustomProgressIndicatorWidget())
              : Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF6EDFE),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Dimens.cardRadius),
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.all(Dimens.paddingMedium),
                    itemCount: postStore.postList?.posts?.length,
                    itemBuilder: (context, index) {
                      return _buildFeedCard(postStore.postList?.posts?[index]);
                    },
                  ),
                );
        }));
  }

  Widget _buildFeedCard(SikkaXNews? news) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: Dimens.paddingSmall),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.cardRadiusNewsFeed),
      ),
      elevation: Dimens.cardElevationNewsFeed,
      child: Padding(
        padding: EdgeInsets.all(Dimens.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DeviceUtils.formatDate(news?.createdAt??DateTime.now()), // Format date
              style: AppThemeData.subtitle1,
            ),
            SizedBox(height: Dimens.paddingSmall),
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.cardRadius),
              child: Image.network(
                news?.imageUrl??"",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.image, size: 150, color: Colors.grey),
              ),
            ),
            SizedBox(height: Dimens.paddingSmall),
            Text(
              news?.title??"",
              style: AppThemeData.headline2,
            ),
            SizedBox(height: Dimens.paddingSmall),
            Text(
              news?.content??"",
              style: AppThemeData.bodyText,
            ),
          ],
        ),
      ),
    );
  }
}
