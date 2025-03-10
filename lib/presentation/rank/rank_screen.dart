import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/assets.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/presentation/rank/rank_badge.dart';

class RanksScreen extends StatefulWidget {
  @override
  _RanksScreenState createState() => _RanksScreenState();
}

class _RanksScreenState extends State<RanksScreen> {
  List<dynamic> _ranksData = [];

  @override
  void initState() {
    super.initState();
    _loadRankData();
  }

  Future<void> _loadRankData() async {
    final String response =
        await rootBundle.loadString('assets/json/ranks_data.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _ranksData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.backgroundColor,
      appBar: AppBar(
        title: Text('Ranks',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: Dimens.fontSizeLarge)),
        backgroundColor: AppThemeData.primaryColor,
      ),
      body: _ranksData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(Dimens.paddingMedium),
              child: Column(
                children: [
                  _buildTopRanks(),
                  SizedBox(height: Dimens.paddingSmall),
                  _buildReferralCard(),
                  SizedBox(height: Dimens.paddingSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.paddingSmall),
                    child: Text(
                        "Your ranking depends on how many games you played and how many points you earned in each game",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: Dimens.fontSizeMedium,
                          fontWeight: FontWeight.w500
                        )),
                  ),
                  SizedBox(height: Dimens.paddingSmall),
                  _buildRankList(),
                ],
              ),
            ),
    );
  }

  Widget _buildTopRanks() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppThemeData.rankingGradient,
        borderRadius: BorderRadius.circular(Dimens.borderRadius),
      ),
      padding: EdgeInsets.all(Dimens.paddingMedium),
      child: Column(
        children: [
          Text('Top Players',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimens.fontSizeLarge,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: Dimens.paddingMedium),
          Column(
            children: [
              // First Row - Top 3 ranks
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _ranksData
                    .take(1) // Take first 3 items
                    .map((item) => _buildRankBadge(item))
                    .toList(),
              ),
              const SizedBox(height: 24), // Space between rows
              // Second Row - Remaining ranks
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _ranksData
                    .skip(1) // Skip first 3 items
                    .take(3) // Next 3 items
                    .map((item) => _buildRankBadge(item))
                    .toList(),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRankBadge(Map<String, dynamic> rank) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RankBadge(
          rank: '${rank['rank']}',
          gradientColor: [
            rank['badge'] == 'gold'
                ? Colors.red
                : rank['badge'] == 'silver'
                    ? Colors.amberAccent
                    : rank['badge'] == 'bronze'
                        ? Colors.grey
                        : Colors.blue,
            Colors.transparent
          ],
        ),
        SizedBox(height: Dimens.paddingSmall),
        Text(rank['name'],
            style: TextStyle(
                color: Colors.white, fontSize: Dimens.defaultFontSize)),
        Text(rank['points'],
            style: TextStyle(
                color: Colors.white70, fontSize: Dimens.defaultFontSize)),
      ],
    );
  }

  Widget _buildReferralCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppThemeData.referFriendGradient,
        borderRadius: BorderRadius.circular(Dimens.borderRadius),
      ),
      padding: EdgeInsets.all(Dimens.paddingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Refer a Friend',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: Dimens.fontSizeMedium)),
              Text('Invite friends and earn\n10K SikkaX Points per referral!',
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimens.fontSizeSmall)),
              SizedBox(height: Dimens.paddingSmall),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(Dimens.buttonRadius),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimens.buttonPadding),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Invite Friends',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Dimens.defaultLogoSize,
            child: Image.asset(Assets.appLogo),
          ),
        ],
      ),
    );
  }

  Widget _buildRankList() {
    return Column(
        children: _ranksData.map((rank) => _buildRankTile(rank)).toList());
  }

  Widget _buildRankTile(Map<String, dynamic> rank) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.borderRadius)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(rank['name'][0],
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        title: Text(rank['name'],
            style: TextStyle(
                fontSize: Dimens.fontSizeMedium, fontWeight: FontWeight.bold)),
        subtitle: Text(rank['points'],
            style: TextStyle(
                fontSize: Dimens.fontSizeSmall, color: AppThemeData.greyText)),
        trailing: Text('#${rank['rank']}',
            style: TextStyle(
                fontSize: Dimens.fontSizeLarge, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
