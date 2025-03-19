import 'package:flutter/material.dart';
import 'package:sikka_wallet/constants/assets.dart';
import 'package:sikka_wallet/core/widgets/custom_app_bar_widget.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/presentation/feed/news_feed_screen.dart';
import 'package:sikka_wallet/presentation/game/game_screen.dart';
import 'package:sikka_wallet/presentation/home/dashboard.dart';
import 'package:sikka_wallet/presentation/post/store/post_store.dart';
import 'package:sikka_wallet/presentation/rank/rank_screen.dart';
import 'package:sikka_wallet/presentation/wallet/wallet_screen.dart';
import 'package:sikka_wallet/utils/locale/app_localization.dart';
import 'package:sikka_wallet/utils/routes/routes.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final PostStore postStore = getIt<PostStore>();
  @override
  void initState() {
    super.initState();
    postStore.getWalletData();
    postStore.getTransactionHistory();
  }
  final List<Widget> _screens = [
    HomeScreen(),
    GamesScreen(),
    WalletScreen(),
    RanksScreen(),
    NewsFeedScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onNotificationPressed: () {
          Navigator.pushNamed(context, Routes.notification);
        },
        onProfilePressed: () {
          // Handle profile button press
        },
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(Assets.sikkaIcon,height: 18,), label: context.translate("home")),
          BottomNavigationBarItem(
              icon: Image.asset(Assets.gameIcon,height: 18,),
              label: context.translate("games")),
          BottomNavigationBarItem(
              icon: Image.asset(Assets.walletIcon,height: 18,),
              label: context.translate("wallet")),
          BottomNavigationBarItem(
              icon: Image.asset(Assets.rankIcon,height: 18,),
              label: context.translate("ranks")),
          BottomNavigationBarItem(
              icon: Image.asset(Assets.feedIcon,height: 18,),
              label: context.translate("feed")),
        ],
      ),
    );
  }
}

extension Translate on BuildContext {
  String translate(String key) => AppLocalizations.of(this)!.translate(key);
}
