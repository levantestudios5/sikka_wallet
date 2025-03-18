import 'package:flutter/material.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/utils/locale/app_localization.dart';

class ExchangeScreen extends StatefulWidget {
  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  TextEditingController sikxController = TextEditingController(text: "12000");
  TextEditingController shibController = TextEditingController(text: "10.00");

  String? sikxError;
  String? shibError;

  void _validateAndConvert({bool isSikxChanged = false}) {
    double? sikxValue = double.tryParse(sikxController.text);
    double? shibValue = double.tryParse(shibController.text);

    if (sikxValue == null || sikxValue <= 0) {
      setState(() => sikxError = "Enter a valid SIKX amount");
      return;
    } else {
      sikxError = null;
    }

    if (isSikxChanged) {
      shibValue = sikxValue / 1200;
      shibController.text = shibValue.toStringAsFixed(2);
    }
    setState(() {});
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
          AppLocalizations.of(context).translate('exchange_sikx_to_shib'),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimens.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildExchangeInfoCard(context),
            SizedBox(height: Dimens.paddingLarge),
            SingleChildScrollView(
                child: _buildTextFieldRow(context, sikxController, "sikx_coins",
                    "12.6K", sikxError, true)),
            _buildSwapIcon(),
            _buildTextFieldRow(context, shibController, "shiba_inu_coins", "",
                shibError, false),
            SizedBox(height: Dimens.paddingLarge),
            _buildInfoBox(context),
            Spacer(),
            _buildExchangeButton(context),
          ],
        ),
      ),
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
            AppLocalizations.of(context).translate('exchange_economy'),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: Dimens.paddingSmall),
          Text(
            AppLocalizations.of(context).translate('exchange_details'),
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
            "${AppLocalizations.of(context).translate('available')} $availableAmount",
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
        onPressed: () {},
        child: Text(AppLocalizations.of(context).translate('exchange_button')),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.borderRadius),
          ),
        ),
      ),
    );
  }
}
