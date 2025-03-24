import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/assets.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/domain/entity/leaderboard/leaderboard.dart';
import 'package:sikka_wallet/presentation/login/store/login_store.dart';
import 'package:sikka_wallet/presentation/post/store/post_store.dart';

class RanksScreen extends StatefulWidget {
  @override
  _RanksScreenState createState() => _RanksScreenState();
}

class _RanksScreenState extends State<RanksScreen> {
  final PostStore postStore = getIt<PostStore>();
  final UserStore userStore = getIt<UserStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA455F8),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF6EDFE),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Dimens.cardRadius),
          ),
        ),
        child: Observer(builder: (context) {
          postStore.leaderBoardEntryList;
          return postStore.loadingRanks
              ? Center(child: CircularProgressIndicator())
              : (postStore.leaderBoardEntryList?.posts?.length ?? 0) > 0
                  ? SingleChildScrollView(
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
                                    fontSize: Dimens.fontSmall,
                                    fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(height: Dimens.paddingSmall),
                          buildRankList(),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.rankIcon,
                            color: Colors.grey,
                            height: 250,
                          ),
                          Text(
                            "You got no users at the moment!",
                            textAlign: TextAlign.center,
                            style: AppThemeData.buttonTextStyle
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
        }),
      ),
    );
  }

  Widget _buildTopRanks() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(Assets.rankBackDrop)),
        gradient: AppThemeData.rankingGradient,
        borderRadius: BorderRadius.circular(Dimens.borderRadius),
      ),
      padding: EdgeInsets.all(Dimens.paddingMedium),
      child: Column(
        children: [
          Observer(builder: (context) {
            postStore.leaderBoardEntryList;
            return Column(
              children: [
                // First Row - Top 3 ranks
                postStore.leaderBoardEntryList?.posts != null &&
                        postStore.leaderBoardEntryList!.posts!.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: postStore.leaderBoardEntryList!.posts!
                            .take(1) // Take first item
                            .map((item) => _buildRankBadge(item))
                            .toList(),
                      )
                    : SizedBox(),

                const SizedBox(height: 24), // Space between rows
                // Second Row - Remaining ranks
                postStore.leaderBoardEntryList?.posts != null &&
                        postStore.leaderBoardEntryList!.posts!.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: postStore.leaderBoardEntryList!.posts!
                            .skip(1) // Skip first 3 items
                            .take(2) // Next 3 items
                            .map((item) => _buildRankBadge(item))
                            .toList(),
                      )
                    : SizedBox(),
              ],
            );
          })
        ],
      ),
    );
  }

  Widget _buildRankBadge(LeaderBoardEntry leaderboard) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/rank${leaderboard.rank}.png',
          height: 56,
        ),
        Text(
          leaderboard.fullName,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: Dimens.defaultFontSize),
        ),
        Text(
          "${leaderboard.sikkaXPoints.toString().split('.')[0]} Points",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: Dimens.defaultFontSize),
        ),
      ],
    );
  }

  List<Color> _getBadgeColor(int rank) {
    if (rank == 1) {
      return [Colors.red, Colors.transparent]; // Gold
    } else if (rank == 2) {
      return [Colors.amberAccent, Colors.transparent]; // Silver
    } else if (rank == 3) {
      return [Colors.grey, Colors.transparent]; // Bronze
    } else {
      return [Colors.blue, Colors.transparent]; // Others
    }
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
              Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(Dimens.buttonRadius)),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      Text(
                        userStore.currentUser?.inviteCode ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.5,
                            color: Colors.white),
                      ),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            copyToClipboard(
                              userStore.currentUser?.inviteCode ?? "",
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Copied to clipboard!")),
                            );
                          },
                          child: Icon(
                            Icons.copy,
                            color: Colors.white,
                            size: 18,
                          ))
                    ],
                  )
                  // Row(children: [
                  //   Text('SikkaX1213'),
                  //   Spacer(),
                  //   Icon(Icons.copy,color: Colors.white,size: 18,)
                  // ],),
                  )
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

  Widget buildRankList() {
    return Observer(builder: (context) {
      postStore.leaderBoardEntryList;
      return postStore.leaderBoardEntryList?.posts != null &&
              postStore.leaderBoardEntryList!.posts!.isNotEmpty
          ? Column(
              children: postStore.leaderBoardEntryList!.posts!
                  .map((rank) => buildRankTile(rank))
                  .toList())
          : SizedBox();
    });
  }

  Widget buildRankTile(LeaderBoardEntry leaderboard) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(bottom: 1),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            leaderboard.fullName[0], // First letter of the name
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          leaderboard.fullName,
          style: TextStyle(
            fontSize: Dimens.fontSizeMedium,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${leaderboard.sikkaXPoints.toStringAsFixed(0)} Points",
          // Display points with one decimal
          style: TextStyle(
            fontSize: Dimens.fontSizeSmall,
            color: AppThemeData.greyText,
          ),
        ),
        trailing: Text(
          '#${leaderboard.rank}',
          style: TextStyle(
            fontSize: Dimens.fontSizeLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
