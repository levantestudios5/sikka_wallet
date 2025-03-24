import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/constants/strings.dart';
import 'package:sikka_wallet/core/widgets/progress_indicator_widget.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/domain/entity/wallet/wallet_conversion_request.dart';
import 'package:sikka_wallet/presentation/post/store/post_store.dart';
import 'package:sikka_wallet/utils/locale/app_localization.dart';

class ConversionScreen extends StatefulWidget {
  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final PostStore postStore = getIt<PostStore>();
  TextEditingController sikxController = TextEditingController(text: "1.00");
  TextEditingController sikaPointController =
      TextEditingController(text: "0.00");
  String? sikxError;
  String? shibError;

  void _validateAndConvert({bool isSikxChanged = false}) {
    double? sikxValue = double.tryParse(sikxController.text);
    double? shibValue = double.tryParse(sikaPointController.text);

    if (sikxValue == null || sikxValue <= 0) {
      setState(() => sikxError = "Enter a valid SIKX amount");
      return;
    } else {
      sikxError = null;
    }
    if (isSikxChanged) {
      shibValue = sikxValue / 1;
      sikaPointController.text = shibValue.toStringAsFixed(2);
    }
    setState(() {});
  }

  @override
  void initState() {
    sikxController.text = postStore.walletData?.sikkaXPoints.toString() ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back, color: Colors.black)),
        title: Text(
          AppLocalizations.of(context).translate('exchange_sika'),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Observer(builder: (context) {
        return postStore.fetchConversionFuture.status == FutureStatus.pending
            ? CustomProgressIndicatorWidget()
            : Padding(
                padding: EdgeInsets.all(Dimens.paddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildExchangeInfoCard(context),
                    SizedBox(height: Dimens.paddingLarge),
                    SingleChildScrollView(
                        child: _buildTextFieldRow(
                            context,
                            sikxController,
                            "sikx_points",
                            "${postStore.walletData?.sikkaXPoints ?? 0}",
                            sikxError,
                            true)),
                    _buildSwapIcon(),
                    _buildTextFieldRow(context, sikaPointController,
                        "sikx_coins", "", shibError, false),
                    Spacer(),
                    _buildExchangeButton(context),
                  ],
                ),
              );
      }),
    );
  }

  Widget _buildExchangeInfoCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimens.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.borderRadius),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).translate('exchange_sikka'),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: Dimens.paddingSmall),
          Text(
            AppLocalizations.of(context).translate('exchange_sikka_details'),
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldRow(
      BuildContext context,
      TextEditingController controller,
      String coinKey,
      String availableAmount,
      String? error,
      bool isSikx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                enabled: isSikx,
                style: TextStyle(
                    fontSize: Dimens.textSizeLarge,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorText: error,
                ),
                onChanged: (value) =>
                    _validateAndConvert(isSikxChanged: isSikx),
              ),
            ),
            Text(AppLocalizations.of(context).translate(coinKey),
                style: TextStyle(color: Colors.grey[700])),
          ],
        ),
        Divider(thickness: 1, color: Colors.grey[300]),
        if (availableAmount.isNotEmpty)
          Text(
            "${AppLocalizations.of(context).translate('available')} ${availableAmount ?? 0}",
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
      ],
    );
  }

  Widget _buildSwapIcon() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimens.paddingMedium),
      child: Icon(Icons.swap_vert, size: Dimens.iconSize, color: Colors.grey),
    );
  }

  Widget _buildInfoBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimens.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.borderRadius),
        border: Border.all(color: Colors.blue),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue),
          SizedBox(width: Dimens.paddingSmall),
          Expanded(
            child: Text(
              AppLocalizations.of(context).translate('launch_message'),
              style: TextStyle(color: Colors.grey[800], fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Dimens.buttonHeightLarge,
      child: ElevatedButton(
        onPressed: () async {
          if (double.parse(
                      postStore.walletData?.sikkaXPoints.toString() ?? "0.0") >
                  0 &&
              double.parse(sikxController.text) > 0 &&
              double.parse(sikxController.text) <=
                  double.parse(
                      postStore.walletData?.sikkaXPoints.toString() ?? "0.0")) {
            await postStore.convertCurrency(WalletConversionRequest(
                amount: double.parse(sikxController.text),
                conversionType: Strings.sikkx));
          } else {
            _showErrorMessage(
                'You have insufficient coins ${postStore.walletData?.sikkaXPoints.toString()} for this transaction!');
          }
        },
        child: Text(AppLocalizations.of(context).translate('convert')),
        style: ElevatedButton.styleFrom(
          backgroundColor: double.parse(
                      postStore.walletData?.sikkaXPoints.toString() ?? "0.0") <
                  1
              ? Colors.grey
              : Colors.purple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.borderRadius),
          ),
        ),
      ),
    );
  }

  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('home_tv_error'),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }
}
