import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/assets.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/core/widgets/progress_indicator_widget.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/domain/entity/transaction/transaction.dart';
import 'package:sikka_wallet/presentation/post/store/post_store.dart';
import 'package:sikka_wallet/utils/device/device_utils.dart';
import 'package:sikka_wallet/utils/locale/app_localization.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final PostStore postStore = getIt<PostStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Notification",
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back, color: Colors.black))),
      body: Observer(builder: (context) {
        return _buildNotificationList();
      }),
    );
  }

  Widget _buildNotificationList() {
    return Observer(builder: (context) {
      return postStore.fetchTransactionFuture.status == FutureStatus.pending
          ? CustomProgressIndicatorWidget()
          : Observer(builder: (context) {
              return (postStore.transactionList?.posts?.length??0)>0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: postStore.transactionList!.posts!.length,
                      itemBuilder: (context, index) {
                        return _buildNotificationCard(
                            postStore.transactionList!.posts![index]);
                      },
                    )
                  :

              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_none_outlined,
                      color: Colors.grey,
                      size: 200,
                    ),
                    Text(
                      (AppLocalizations.of(context)
                          .translate('no_notification')),
                      textAlign: TextAlign.center,
                      style: AppThemeData.buttonTextStyle
                          .copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              );

              Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimens.spacingMedium,
                          horizontal: Dimens.radiusSmall),
                      child: Text(AppLocalizations.of(context)
                          .translate('no_notification')),
                    );
            });
    });
  }

  Widget _buildNotificationCard(Transaction transaction) {
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
