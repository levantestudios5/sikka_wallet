import 'package:flutter/material.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/assets.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/core/widgets/custom_circular_button.dart';
import 'package:sikka_wallet/presentation/home/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA455F8),
      body: Stack(
        children: [
          _buildHeader(context),
          Align(
              alignment: Alignment.bottomCenter,
              child: _showDraggableSheet(context)),
        ],
      ),
    );
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
        children: [
          SizedBox(
            height: Dimens.paddingSmall,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    Assets.splashIcon,
                    height: 20,
                  ),
                  SizedBox(width: Dimens.inputSpacing),
                  Text(context.translate("app_name"),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Row(children: [
                CircularButtonWithLabel(
                  icon: Icons.notifications_none_outlined,
                  iconColor: Colors.white,
                  size: 40,
                  borderColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    _showDraggableSheet(context);
                  },
                  label: '',
                ),
                SizedBox(width: Dimens.paddingSmall),
                CircularButtonWithLabel(
                  icon: Icons.person_3_outlined,
                  size: 40,
                  iconColor: Colors.white,
                  borderColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  onPressed: () {},
                  label: '',
                ),
              ])
            ],
          ),
          SizedBox(height: Dimens.padding),
          Image.asset("assets/icons/ic_appicon.png", height: 126),
          Text(context.translate("balance"),
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          Text("12.6K",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text(context.translate("sikka_points"),
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          SizedBox(height: Dimens.padding),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppThemeData.primaryDarkColor),
            onPressed: () {},
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
                onPressed: () {}, child: Text(context.translate("see_all"))),
          ]),
          SizedBox(height: Dimens.padding),
          SizedBox(
            height: Dimens.gameCardHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (_, index) => _buildGameCard(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard() {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: Dimens.padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.radius),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2)
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.radius),
        child: Image.asset("assets/images/crypto_crush.png", fit: BoxFit.cover),
      ),
    );
  }

  Widget _showDraggableSheet(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
