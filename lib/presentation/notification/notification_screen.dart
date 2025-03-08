import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/dimens.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final String response =
        await rootBundle.loadString('assets/json/notifications.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _notifications = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Notification",
          ),
          leading: Icon(Icons.arrow_back, color: Colors.black)),
      body: _notifications.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(Dimens.paddingSmall),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(_notifications[index]);
              },
            ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> item) {
    bool isExchange = item['type'] == 'EXCHANGE';
    return Card(
      elevation: Dimens.elevationLow,
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
