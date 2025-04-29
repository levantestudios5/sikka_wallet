import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/core/stores/form/form_store.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/domain/entity/auth/authentication_response.dart';
import 'package:sikka_wallet/presentation/login/store/login_store.dart';
import 'package:sikka_wallet/utils/device/device_utils.dart';
import 'package:sikka_wallet/utils/locale/app_localization.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _emailController = TextEditingController();
  final UserStore userStore = getIt<UserStore>();
  final _store = FormStore();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildWelcomeText(),
              _buildTextField(
                controller: _emailController,
                hintKey: 'email_address',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('email_error_empty');
                  }
                  if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return AppLocalizations.of(context)
                        .translate('email_error_invalid');
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimens.buttonRadius),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimens.buttonPadding),
                ),
                onPressed: () async {
                  if (_emailController.text.isNotEmpty) {
                    DeviceUtils.hideKeyboard(context);
                    await userStore.resetPassword(_emailController.text.trim());
                    showDialog(
                      context: context,
                      builder: (BuildContext childContext) {
                        return AlertDialog(
                          title: Text('Reset Link Sent'),
                          content:
                              Text('Reset link has been sent to your email.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                _emailController.text = "";
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    _showErrorMessage('Please fill in all fields');
                  }
                },
                child: Text(
                  'Send Reset Link',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Reset Password',
          style: TextStyle(
            fontSize: 17.5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 8,
        ),
        const Text(
          "Reset your password from here.",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 13.5,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintKey,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.inputSpacing),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate(hintKey),
          hintStyle: AppThemeData.subtitleStyle.copyWith(color: Colors.black54),
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
          errorStyle: TextStyle(
            color: Colors.red, // Customize the color of the validation text
            fontSize: 10.0, // Adjust font size
            fontWeight: FontWeight.w300, // Make it bold
          ),
        ),
        validator: validator,
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
