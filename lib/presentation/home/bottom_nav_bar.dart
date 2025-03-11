import 'package:flutter/material.dart';
import 'package:sikka_wallet/presentation/feed/news_feed_screen.dart';
import 'package:sikka_wallet/presentation/game/game_screen.dart';
import 'package:sikka_wallet/presentation/home/dashboard.dart';
import 'package:sikka_wallet/presentation/rank/rank_screen.dart';
import 'package:sikka_wallet/presentation/wallet/wallet_screen.dart';
import 'package:sikka_wallet/utils/locale/app_localization.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

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
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: context.translate("home")),
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: context.translate("games")),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: context.translate("wallet")),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: context.translate("ranks")),
          BottomNavigationBarItem(icon: Icon(Icons.rss_feed), label: context.translate("feed")),
        ],
      ),
    );
  }
}
extension Translate on BuildContext {
  String translate(String key) => AppLocalizations.of(this)!.translate(key);
}