import 'package:sikka_wallet/presentation/home/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:sikka_wallet/presentation/home/profile_screen.dart';
import 'package:sikka_wallet/presentation/notification/notification_screen.dart';
import 'package:sikka_wallet/presentation/registration/signin_screen.dart';
import 'package:sikka_wallet/presentation/registration/signup_screen.dart';
import 'package:sikka_wallet/presentation/wallet/conversion_screen.dart';
import 'package:sikka_wallet/presentation/wallet/exchange_screen.dart';
import 'package:sikka_wallet/presentation/wallet/widraw_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/post';
  static const String notification = '/notification';
  static const String profile = '/profile';
  static const String conversionScreen = '/conversion';
  static const String withdraw = '/withdraw';
  static const String exchange = '/exchange';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    signUp: (BuildContext context) => SignupScreen(),
    home: (BuildContext context) => BottomNavBar(),
    conversionScreen: (BuildContext context) => ConversionScreen(),
    notification: (BuildContext context) => NotificationScreen(),
    withdraw: (BuildContext context) => WithdrawScreen(),
    profile: (BuildContext context) => ProfileScreen(),
    exchange: (BuildContext context) => ExchangeScreen(),
  };
}
