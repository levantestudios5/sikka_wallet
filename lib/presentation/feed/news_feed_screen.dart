import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sikka_wallet/constants/dimens.dart';

import '../../constants/app_theme.dart';

class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  List<dynamic> _feedData = [];

  @override
  void initState() {
    super.initState();
    _loadFeedData();
  }

  Future<void> _loadFeedData() async {
    final String response =
        await rootBundle.loadString('assets/json/feed_data.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _feedData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          title: Text('Feed', style: AppThemeData.headline1),
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
            IconButton(icon: Icon(Icons.person_outline), onPressed: () {}),
          ],
        ),
        body: _feedData.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Dimens.cardRadius),
                  ),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.all(Dimens.paddingMedium),
                  itemCount: _feedData.length,
                  itemBuilder: (context, index) {
                    return _buildFeedCard(_feedData[index]);
                  },
                ),
              ));
  }

  Widget _buildFeedCard(Map<String, dynamic> item) {
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
            Text(item['date'], style: AppThemeData.subtitle1),
            SizedBox(height: Dimens.paddingSmall),
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.cardRadius),
              child: Image.network(item['image'],
                  fit: BoxFit.cover, width: double.infinity, height: 150),
            ),
            SizedBox(height: Dimens.paddingSmall),
            Text(item['title'], style: AppThemeData.headline2),
            SizedBox(height: Dimens.paddingSmall),
            Text(item['description'], style: AppThemeData.bodyText),
          ],
        ),
      ),
    );
  }
}
