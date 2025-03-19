import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/assets.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/core/widgets/custom_circular_button.dart';
import 'package:sikka_wallet/core/widgets/progress_indicator_widget.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/domain/entity/transaction/transaction.dart';
import 'package:sikka_wallet/presentation/post/store/post_store.dart';
import 'package:sikka_wallet/utils/device/device_utils.dart';
import 'package:sikka_wallet/utils/locale/app_localization.dart';
import 'package:sikka_wallet/utils/routes/routes.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final PostStore postStore = getIt<PostStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA455F8),
      body: Flexible(
        child: Container(
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
      ),
    );
  }

  Widget _buildWalletCard() {
    return Observer(builder: (context) {
      return postStore.loadingWallet
          ? CustomProgressIndicatorWidget()
          : SizedBox(
              height: 400, // Set height for horizontal scrolling
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: postStore.coinsList.length,
                itemBuilder: (context, index) {
                  final item = postStore.coinsList[index];
                  return _buildWalletItemCard(item);
                },
              ),
            );
    });
  }

  Widget _buildWalletItemCard(Map<String, dynamic> coin) {
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
            Image.asset(Assets.shiba, width: Dimens.coinSize),
            SizedBox(height: Dimens.spacingMedium),
            Text(
              "${double.parse(coin['amount']).toStringAsFixed(3)}",
              // Adjusted for balance
              style: TextStyle(
                fontSize: Dimens.fontExtraLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Dimens.spacingSmall),
            Text(
              "${coin['name']}", // Adjusted for description (Coin Name)
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: Dimens.spacingMedium),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                coin['name'].toString().contains('Shiba')
                    ? CircularButtonWithLabel(
                        backgroundColor: Colors.transparent,
                        label: 'withdraw',
                        icon: Icons.keyboard_arrow_down_rounded,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.withdraw);
                        },
                      )
                    : SizedBox(),
                coin['name'].toString().contains('SikkaX')
                    ? CircularButtonWithLabel(
                        backgroundColor: Colors.transparent,
                        label: 'exchange',
                        icon: Icons.swap_horiz_outlined,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.exchange);
                        },
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ));
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
    return Observer(builder: (context) {
      return postStore.fetchTransactionFuture.status == FutureStatus.pending
          ? CustomProgressIndicatorWidget()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    AppLocalizations.of(context).translate('transactions'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.fontMedium),
                  ),
                ),
                Observer(builder: (context) {
                  return postStore.transactionList!.posts!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: postStore.transactionList!.posts!.length,
                          itemBuilder: (context, index) {
                            return _buildTransactionCard(
                                postStore.transactionList!.posts![index]);
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimens.spacingMedium,
                              horizontal: Dimens.radiusSmall),
                          child: Text(AppLocalizations.of(context)
                              .translate('no_transactions')),
                        );
                }),
              ],
            );
    });
  }

  Widget _buildTransactionCard(Transaction transaction) {
    bool isExchange = transaction.type == 'EXCHANGE';
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(Dimens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  DeviceUtils.formatDate(
                      transaction.createdAt ?? DateTime.now()),
                  style: AppThemeData.dateStyle,
                ),
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
                    transaction.type ?? "",
                    style: AppThemeData.subtitleStyle
                        .copyWith(fontSize: Dimens.spacingMedium),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimens.paddingSmall),
            Text(transaction.description ?? "",
                style: AppThemeData.messageStyle),
          ],
        ),
      ),
    );
  }
}
