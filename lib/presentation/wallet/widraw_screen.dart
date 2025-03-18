import 'package:flutter/material.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/utils/locale/app_localization.dart';

class WithdrawScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController walletController = TextEditingController();
  final TextEditingController amountController =
      TextEditingController(text: "10.00");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,size: Dimens.iconSize),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context).translate('withdraw'),
            style: TextStyle(fontSize: Dimens.titleSize)),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        // Hide keyboard when tapping outside
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Dimens.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(context),
              SizedBox(height: Dimens.spacingLarge),
              _buildWithdrawalForm(context),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Information Card (Blue Box)
  Widget _buildInfoCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimens.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.borderRadius),
        border: Border.all(color: Colors.blue),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info, color: Colors.blue, size: Dimens.iconSize),
          SizedBox(width: Dimens.spacingSmall),
          Expanded(
            child: Text(
              AppLocalizations.of(context).translate('withdraw_info'),
              style: TextStyle(fontSize: Dimens.defaultFontSize),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Withdrawal Form UI
  Widget _buildWithdrawalForm(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.cardRadius),
      ),
      elevation: Dimens.cardElevation,
      child: Padding(
        padding: EdgeInsets.all(Dimens.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context).translate('withdrawal_details'),
                style: TextStyle(
                    fontSize: Dimens.titleSize, fontWeight: FontWeight.bold)),
            SizedBox(height: Dimens.spacingSmall),
            Text(
                AppLocalizations.of(context)
                    .translate('withdrawal_description'),
                style: TextStyle(fontSize: Dimens.textSize)),
            SizedBox(height: Dimens.spacingMedium),
            _buildTextField(context, nameController, 'full_name'),
            _buildTextField(context, emailController, 'email'),
            _buildTextField(context, walletController, 'wallet_no'),
            _buildAmountField(context),
            SizedBox(height: Dimens.spacingLarge),
            _buildWithdrawButton(context),
          ],
        ),
      ),
    );
  }

  /// 🔹 Generic Text Field
  Widget _buildTextField(
      BuildContext context, TextEditingController controller, String labelKey) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.spacingSmall),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate(labelKey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonRadius),
            borderSide:
                const BorderSide(color: Colors.black26), // Light black border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonRadius),
            borderSide: const BorderSide(
                color: Colors.black26,
                width: 1.0), // Slightly thicker when focused
          ),
        ),
      ),
    );
  }

  /// 🔹 Amount Field with "SHIB" Label
  Widget _buildAmountField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.spacingSmall),
      child: TextFormField(
        controller: amountController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "10.00",
          suffixText: "SHIB",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonRadius),
            borderSide:
                const BorderSide(color: Colors.black26), // Light black border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonRadius),
            borderSide: const BorderSide(
                color: Colors.black26,
                width: 1.0), // Slightly thicker when focused
          ),
        ),
      ),
    );
  }

  /// 🔹 Withdraw Button
  Widget _buildWithdrawButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppThemeData.primaryDarkColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.buttonRadius)),
          padding: EdgeInsets.all(Dimens.buttonPadding),
        ),
        onPressed: () {
          showWithdrawalPendingPopup(context, emailController.text);
        },
        child: Text(AppLocalizations.of(context).translate('withdraw'),
            style: TextStyle(
                fontSize: Dimens.buttonTextSize, color: Colors.white)),
      ),
    );
  }

  void showWithdrawalPendingPopup(BuildContext context, String maskedEmail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.dialogRadius)),
          child: Padding(
            padding: EdgeInsets.all(Dimens.padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, size: Dimens.iconSize),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/shiba.png',
                        width: Dimens.iconSizeLarge),
                    SizedBox(
                      width: Dimens.paddingSmall,
                    ),
                    Icon(Icons.arrow_forward, size: Dimens.iconSize),
                    SizedBox(
                      width: Dimens.paddingSmall,
                    ),
                    Image.asset('assets/icons/wallet.png',
                        width: Dimens.iconSizeLarge),
                  ],
                ),
                SizedBox(height: Dimens.appBarFontSize),
                Text(
                  AppLocalizations.of(context).translate('withdrawal_pending'),
                  style: TextStyle(
                      fontSize: Dimens.titleSize, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: Dimens.spacingSmall),
                Text(
                  "${AppLocalizations.of(context).translate('withdrawal_message')} $maskedEmail.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Dimens.textSize),
                ),
                SizedBox(height: Dimens.spacingMedium),
              ],
            ),
          ),
        );
      },
    );
  }
}
