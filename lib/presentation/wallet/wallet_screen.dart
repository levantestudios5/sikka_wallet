import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/core/widgets/custom_circular_button.dart';
import 'package:sikka_wallet/utils/locale/app_localization.dart';
import 'package:sikka_wallet/utils/routes/routes.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<dynamic> _transactions = [];
  List<dynamic> _walletCards = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
    _loadWalletCards();
  }

  Future<void> _loadTransactions() async {
    final String response =
        await rootBundle.loadString('assets/json/notifications.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _transactions = data;
    });
  }

  Future<void> _loadWalletCards() async {
    final String response =
        await rootBundle.loadString('assets/json/wallet_card.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _walletCards = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA455F8),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimens.cornerRadiusLarge),
            topRight: Radius.circular(Dimens.cornerRadiusLarge),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Dimens.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildWalletCard(),
              SizedBox(height: Dimens.spacingLarge),
              _buildAnnouncement(),
              SizedBox(height: Dimens.spacingLarge),
              _buildTransactionList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWalletCard() {
    return SizedBox(
      height: 400, // Set height for horizontal scrolling
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _walletCards.length,
        itemBuilder: (context, index) {
          final item = _walletCards[index];
          return _buildWalletItemCard(item);
        },
      ),
    );
  }

  Widget _buildWalletItemCard(Map<String, dynamic> item) {
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
      padding: EdgeInsets.all(Dimens.paddingLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.cornerRadiusLarge),
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.white60],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(item['icon'], width: Dimens.coinSize),
          SizedBox(height: Dimens.spacingMedium),
          Text(item['balance'],
              style: TextStyle(
                  fontSize: Dimens.fontExtraLarge,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: Dimens.spacingSmall),
          Text(item['description'], style: TextStyle(color: Colors.grey)),
          SizedBox(height: Dimens.spacingMedium),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              item['balance'].toString().contains('SIKX')
                  ? SizedBox()
                  : CircularButtonWithLabel(
                      backgroundColor: Colors.transparent,
                      label: 'withdraw',
                      icon: Icons
                          .keyboard_arrow_down_rounded, // Change to your desired icon
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.withdraw);
                        // Button action
                      },
                    ),
              item['balance'].toString().contains('SIKX')
                  ? SizedBox()
                  : SizedBox(width: Dimens.radiusMedium),
              CircularButtonWithLabel(
                backgroundColor: Colors.transparent,

                label: 'exchange',
                icon: Icons.swap_horiz_outlined, // Change to your desired icon
                onPressed: () {
                  // Button action
                  Navigator.pushNamed(context, Routes.exchange);

                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAnnouncement() {
    return Container(
      padding: EdgeInsets.all(Dimens.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(Dimens.cornerRadiusMedium),
      ),
      child: Row(
        children: [
          Icon(Icons.announcement_outlined, color: Colors.purple),
          SizedBox(width: Dimens.spacingSmall),
          Expanded(
            child: Text(
              AppLocalizations.of(context).translate('announcement_text'),
              style: TextStyle(
                  color: Colors.purple.shade800, fontSize: Dimens.fontSmall),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            AppLocalizations.of(context).translate('transactions'),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: Dimens.fontMedium),
          ),
        ),
        _transactions.isEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: Dimens.spacingMedium),
                child: Text(
                    AppLocalizations.of(context).translate('no_transactions')),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  return _buildTransactionCard(_transactions[index]);
                },
              ),
      ],
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> item) {
    bool isExchange = item['type'] == 'EXCHANGE';
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(Dimens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(item['date'], style: AppThemeData.dateStyle),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimens.inputRadius,
                      vertical: Dimens.cardElevation),
                  decoration: BoxDecoration(
                    color: isExchange
                        ? AppThemeData.exchangeColor
                        : AppThemeData.withdrawalColor,
                    borderRadius: BorderRadius.circular(Dimens.spacingLarge),
                  ),
                  child: Text(
                    item['type'],
                    style: AppThemeData.subtitleStyle
                        .copyWith(fontSize: Dimens.spacingMedium),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimens.paddingSmall),
            Text(item['message'], style: AppThemeData.messageStyle),
          ],
        ),
      ),
    );
  }
}
