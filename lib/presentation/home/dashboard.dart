import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/assets.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/core/widgets/game_card.dart';
import 'package:sikka_wallet/core/widgets/progress_indicator_widget.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/domain/entity/leaderboard/leaderboard.dart';
import 'package:sikka_wallet/domain/entity/news/news_feed.dart';
import 'package:sikka_wallet/presentation/home/bottom_nav_bar.dart';
import 'package:sikka_wallet/presentation/login/store/login_store.dart';
import 'package:sikka_wallet/presentation/post/store/post_store.dart';
import 'package:sikka_wallet/utils/device/device_utils.dart';
import 'package:sikka_wallet/utils/routes/routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostStore postStore = getIt<PostStore>();
  final UserStore userStore = getIt<UserStore>();

  @override
  void initState() {
    userStore.getUserObject();
    postStore.getWalletData();
    postStore.getAllGames();
    postStore.getLeaderBoard();
    postStore.getPosts();
    postStore.getTransactionHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFA455F8),
        body: Stack(
          children: [
            Align(alignment: Alignment.topCenter, child: _buildHeader(context)),
            Align(
                alignment: Alignment.bottomCenter,
                child: Observer(builder: (context) {
                  return (postStore.loading == true ||
                          postStore.loadingWallet == true ||
                          postStore.loadingConversion == true ||
                          postStore.loadingRanks == true)
                      ? CustomProgressIndicatorWidget()
                      : _showDraggableSheet(context);
                }))
          ],
        ));
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimens.padding),
      decoration: BoxDecoration(
        gradient: RadialGradient(colors: [
          Color(0xFFD9B5FF),
          Color(0xFFA455F8),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/icons/ic_appicon.png", height: 126),
          Text(context.translate("balance"),
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          Observer(builder: (context) {
            return Text(postStore.walletData?.sikkaXPoints.toString() ?? "0.0",
                style: TextStyle(
                    fontSize: 54,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 8.0,
                        color: Colors.grey.shade800,
                      ),
                    ],
                    fontWeight: FontWeight.w900,
                    color: Colors.white));
          }),
          Text(context.translate("sikka_points"),
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          SizedBox(height: Dimens.padding),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppThemeData.primaryDarkColor),
            onPressed: () {
              Navigator.pushNamed(context, Routes.conversionScreen);
            },
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.sync_alt, color: AppThemeData.primaryDarkColor),
              SizedBox(width: 8),
              Text(context.translate("convert_sikka")),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context) {
    return Card(
      color: Colors.purple.shade50,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.cornerRadiusMedium)),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(Dimens.padding),
        child: Text(
          context.translate("announcement"),
          style: TextStyle(color: AppThemeData.primaryDarkColor, fontSize: 10),
        ),
      ),
    );
  }

  Widget _buildPopularGames(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(context.translate("popular_games"),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
                onPressed: () {
                  setState(() {
                    postStore.updateIndex(1);
                  });
                },
                child: Text(
                  context.translate("see_all"),
                  style: AppThemeData.buttonTextStyle,
                )),
          ]),
          (postStore.gameList?.posts?.length ?? 0) > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildGameGrid(),
                  ],
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.game,
                        height: 250,
                      ),
                      Text(
                        "You got no games to play at the moment!",
                        style: AppThemeData.buttonTextStyle
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildNewsFeed(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(context.translate("news_feed"),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
                onPressed: () {
                  setState(() {
                    postStore.updateIndex(4);
                  });
                },
                child: Text(
                  context.translate("see_all"),
                  style: AppThemeData.buttonTextStyle,
                )),
          ]),
          Observer(builder: (context) {
            return (postStore.postList?.posts?.length ?? 0) > 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildFeedCard(postStore.postList?.posts?[index]);
                    },
                  )
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.feedIcon,
                          height: 250,
                          color: Colors.grey,
                        ),
                        Text(
                          "We have no feed to show you at this time\nStay Tuned for more updates!",
                          textAlign: TextAlign.center,
                          style: AppThemeData.buttonTextStyle
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
          }),
        ],
      ),
    );
  }

  Widget _buildRankings(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(context.translate("rankings"),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
                onPressed: () {
                  setState(() {
                    postStore.updateIndex(3);
                  });
                },
                child: Text(
                  context.translate("see_all"),
                  style: AppThemeData.buttonTextStyle,
                )),
          ]),
          (postStore.leaderBoardEntryList?.posts?.length ?? 0) > 0
              ? buildRankList()
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
                ),
          (postStore.leaderBoardEntryList?.posts?.length ?? 0) > 0
              ? SizedBox(
                  height: 16,
                )
              : SizedBox(),
          (postStore.leaderBoardEntryList?.posts?.length ?? 0) > 0
              ? _buildReferralCard()
              : SizedBox(),
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
                  .take(3)
                  .map((rank) => buildRankTile(rank))
                  .toList())
          : SizedBox();
    });
  }

  Widget _showDraggableSheet(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: DraggableScrollableSheet(
        initialChildSize: 0.46,
        // Start at 50% of screen height
        minChildSize: 0.45,
        // Cannot go lower than 30%
        maxChildSize: 1.0,
        // Can expand to full screen
        expand: true,
        builder: (context, scrollController) {
          return Container(
            padding: EdgeInsets.all(Dimens.padding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.defaultLogoSize),
                topRight: Radius.circular(Dimens.defaultLogoSize),
              ),
            ),
            child: ListView(
              controller: scrollController, // Enables smooth scrolling
              children: [
                _buildAnnouncementCard(context),
                SizedBox(height: Dimens.padding),
                _buildPopularGames(context),
                _buildRankings(context),
                _buildNewsFeed(context)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGameGrid() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      physics: ScrollPhysics(),
      // Replace with actual game count
      itemBuilder: (context, index) {
        return GameCard(
          imageUrl: postStore.gameList!.posts![index].gameIconUrl,
          title: postStore.gameList!.posts![index].name,
          description: postStore.gameList!.posts![index].description,
          onPlayNow: () {
            print("Play Now Clicked!");
          },
        );
      },
    );
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

  Widget _buildReferralCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppThemeData.rankingGradient,
        borderRadius: BorderRadius.circular(Dimens.borderRadius),
      ),
      padding: EdgeInsets.all(12),
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
                  ))
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

  Widget _buildFeedCard(SikkaXNews? news) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DeviceUtils.formatDate(news?.createdAt ?? DateTime.now()),
          // Format date
          style: AppThemeData.subtitle1,
        ),
        SizedBox(height: Dimens.paddingSmall),
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.cardRadius),
          child: Image.network(
            news?.imageUrl ?? "",
            fit: BoxFit.cover,
            width: double.infinity,
            height: 150,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.image, size: 150, color: Colors.grey),
          ),
        ),
        SizedBox(height: Dimens.paddingSmall),
        Text(
          news?.title ?? "",
          style: AppThemeData.headline2,
        ),
        SizedBox(height: Dimens.paddingSmall),
        Text(
          news?.content ?? "",
          style: AppThemeData.bodyText,
        ),
      ],
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
