import 'package:flutter/material.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/utils/locale/app_localization.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppThemeData.baseGradient),
        padding: const EdgeInsets.all(Dimens.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.cardRadius),
              ),
              elevation: Dimens.cardElevation,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.cardPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('login_here'),
                        style: AppThemeData.titleStyle
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate('login_subtitle'),
                        style: AppThemeData.subtitleStyle
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: Dimens.textSpacing),
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
                      _buildPasswordField(),
                      const SizedBox(height: Dimens.textSpacing),
                      _buildLoginButton(),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            const SizedBox(height: Dimens.textSpacing),
            _buildSignUpLink(),
          ],
        ),
      ),
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
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.inputSpacing),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate('password'),
          hintStyle: AppThemeData.subtitleStyle.copyWith(color: Colors.black54),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
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
        validator: (value) {
          if (value!.length < 6) {
            return AppLocalizations.of(context).translate('password_error');
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Handle Signup
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: Dimens.buttonPadding),
        ),
        child: Text(
          AppLocalizations.of(context).translate('login_button'),
          style: AppThemeData.buttonTextStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).translate('not_have_account'),
          style: AppThemeData.subtitleStyle,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(Dimens.buttonRadius),
              ),
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(vertical: Dimens.buttonPadding),
            ),
            child: Text(
              AppLocalizations.of(context).translate('register_now'),
              style: AppThemeData.buttonTextStyle.copyWith(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
