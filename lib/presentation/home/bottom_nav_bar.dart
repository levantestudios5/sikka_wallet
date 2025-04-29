import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sikka_wallet/constants/assets.dart';
import 'package:sikka_wallet/core/data/network/firebase/remote_config_service.dart';
import 'package:sikka_wallet/core/widgets/custom_app_bar_widget.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/presentation/feed/news_feed_screen.dart';
import 'package:sikka_wallet/presentation/game/game_screen.dart';
import 'package:sikka_wallet/presentation/home/dashboard.dart';
import 'package:sikka_wallet/presentation/home/profile_screen.dart';
import 'package:sikka_wallet/presentation/login/store/login_store.dart';
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
  final PostStore postStore = getIt<PostStore>();
  final UserStore userStore = getIt<UserStore>();
  bool shouldShow = false;
  final RemoteConfigService _remoteConfigService = RemoteConfigService();

//todo save invite code in sharefpres
  //todp impl profile screen
  @override
  void initState() {
    _initializeRemoteConfig();
    super.initState();
    userStore.getUserObject();
  }

  Future<void> _initializeRemoteConfig() async {
    print("Initalizing remote config");
    await _remoteConfigService.initialize();
    setState(() {}); // Update UI after fetching values
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  final List<Widget> _screens = [
    HomeScreen(),
    GamesScreen(),
    WalletScreen(),
    RanksScreen(),
    NewsFeedScreen(),
  ];

  final List<Widget> _screensX = [
    HomeScreen(),
    GamesScreen(),
    RanksScreen(),
    NewsFeedScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      postStore.updateIndex(index);
      print("BlackListVersion: ${_remoteConfigService.blackListVersion}");
      print("IsForceUpdate: ${_remoteConfigService.isForceUpdate}");
      print("shouldShowWallet: ${_remoteConfigService.shouldShowWallet}");
      print(
          "ShibaInuConversion: ${_remoteConfigService.shibaInuConversionValue}");
      print("SikkaXConversion: ${_remoteConfigService.sikkaXConversionValue}");
      print("SikkaWalletVersion: ${_remoteConfigService.sikkaWalletVersion}");
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
          Navigator.pushNamed(context, Routes.profile);
        },
      ),
      body: Observer(builder: (context) {
        return IndexedStack(
            index: postStore.selectedIndex,
            children:
                _remoteConfigService.shouldShowWallet ? _screens : _screensX);
      }),
      bottomNavigationBar: Observer(builder: (context) {
        postStore.selectedIndex;
        return BottomNavigationBar(
          currentIndex: postStore.selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            fontSize: 15, // Adjust font size
            fontWeight: FontWeight.bold, // Make selected item bold
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12, // Smaller font size for unselected items
            fontWeight: FontWeight.normal,
          ),
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.sikkaIconSelected,
                  height: 18,
                ),
                activeIcon: Image.asset(
                  Assets.sikkaIcon,
                  height: 18,
                ),
                label: context.translate("home")),
            BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.gameIcon,
                  height: 18,
                ),
                activeIcon: Image.asset(
                  Assets.gameIconSelected,
                  height: 18,
                ),
                label: context.translate("games")),
            if (_remoteConfigService.shouldShowWallet)
              BottomNavigationBarItem(
                  icon: Image.asset(
                    Assets.walletIcon,
                    height: 18,
                  ),
                  activeIcon: Image.asset(
                    Assets.walletIconSelected,
                    height: 18,
                  ),
                  label: context.translate("wallet")),
            BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.rankIcon,
                  height: 18,
                ),
                activeIcon: Image.asset(
                  Assets.rankIconSelected,
                  height: 18,
                ),
                label: context.translate("ranks")),
            BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.feedIcon,
                  height: 18,
                ),
                activeIcon: Image.asset(
                  Assets.feedIconSelected,
                  height: 18,
                ),
                label: context.translate("feed")),
          ],
        );
      }),
    );
  }
}

extension Translate on BuildContext {
  String translate(String key) => AppLocalizations.of(this)!.translate(key);
}
