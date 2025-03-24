import 'dart:convert';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/assets.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/core/widgets/progress_indicator_widget.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/presentation/login/store/login_store.dart';
import 'package:sikka_wallet/utils/locale/app_localization.dart';
import 'package:sikka_wallet/utils/routes/routes.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _inviteCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserStore _userStore = getIt<UserStore>();

  List<DropdownMenuItem<String>> countryItems = [];
  String? selectedCountry;

  Future<void> loadCountries() async {
    try {
      String data = await rootBundle.loadString('assets/json/countries.json');
      Map<String, dynamic> jsonData = jsonDecode(data);

      List<dynamic> countriesList = jsonData['countries'];

      setState(() {
        countryItems = countriesList
            .map<DropdownMenuItem<String>>(
                (country) => DropdownMenuItem<String>(
                      value: country['name'].toString(),
                      child: Text(
                        country['name'].toString(),
                        style: AppThemeData.subtitleStyle.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ))
            .toList();
      });
    } catch (e) {
      debugPrint("Error loading countries: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents automatic resizing
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(gradient: AppThemeData.baseGradient),
          child: Observer(builder: (context) {
            return _userStore.isRegisterLoading
                ? CustomProgressIndicatorWidget()
                : Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(Assets.cover),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.screenPadding),
                          child: SingleChildScrollView(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.manual,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimens.cardRadius),
                                  ),
                                  elevation: Dimens.cardElevation,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        Dimens.cardPadding),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('signup_title'),
                                            style: AppThemeData.titleStyle
                                                .copyWith(color: Colors.black),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('signup_subtitle'),
                                            style: AppThemeData.subtitleStyle
                                                .copyWith(color: Colors.black),
                                          ),
                                          const SizedBox(
                                              height: Dimens.textSpacing),
                                          _buildTextField(
                                            controller: _nameController,
                                            hintKey: 'full_name',
                                            validator: (value) => value!.isEmpty
                                                ? AppLocalizations.of(context)
                                                    .translate('name_error')
                                                : null,
                                          ),
                                          _buildTextField(
                                            controller: _emailController,
                                            hintKey: 'email_address',
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        'email_error_empty');
                                              }
                                              if (!RegExp(
                                                      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                  .hasMatch(value)) {
                                                return AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        'email_error_invalid');
                                              }
                                              return null;
                                            },
                                          ),
                                          _buildPasswordField(),
                                          _buildDropdown(),
                                          _buildTextField(
                                            controller: _inviteCodeController,
                                            hintKey: 'invite_code',
                                          ),
                                          const SizedBox(
                                              height: Dimens.textSpacing),
                                          _buildRegisterButton(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom), // Adjust for keyboard
                              ],
                            ),
                          ),
                        ),
                      ),
                      Observer(
                        builder: (context) {
                          return Visibility(
                            visible: _userStore.isRegisterLoading,
                            child: CustomProgressIndicatorWidget(),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.screenPadding),
                          child: _buildLoginLink(),
                        ),
                      ),
                    ],
                  );
          }),
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
          errorStyle: TextStyle(
            color: Colors.red, // Customize the color of the validation text
            fontSize: 10.0, // Adjust font size
            fontWeight: FontWeight.w300, // Make it bold
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

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.inputSpacing),
      child: DropdownButtonFormField<String>(
        items: countryItems,
        value: selectedCountry,
        hint: Text(
          AppLocalizations.of(context).translate('country'),
          style: AppThemeData.subtitleStyle.copyWith(color: Colors.black54),
        ),
        decoration: InputDecoration(
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
        onChanged: (value) {
          selectedCountry = value;
        },
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          showSignUpPopup(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: Dimens.buttonPadding),
        ),
        child: Text(
          AppLocalizations.of(context).translate('register'),
          style: AppThemeData.buttonTextStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).translate('already_have_account'),
          style: AppThemeData.subtitleStyle,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.login);
            },
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
              AppLocalizations.of(context).translate('login_here'),
              style: AppThemeData.buttonTextStyle.copyWith(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty &&
            !message.contains('Registration successful')) {
          FlushbarHelper.createInformation(
            message: message,
            title: AppLocalizations.of(context).translate('register'),
            duration: Duration(seconds: 3),
          )..show(context);
        } else if (message.isNotEmpty &&
            message.contains('Registration successful')) {
          FlushbarHelper.createSuccess(
            message: message,
            title: AppLocalizations.of(context).translate('register'),
            duration: Duration(seconds: 3),
          )..show(context);
          Navigator.pushReplacementNamed(context, Routes.login);
        }
      });
    }

    return SizedBox.shrink();
  }

  void showSignUpPopup(BuildContext context) {
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
                Image.asset(Assets.appLogo, height: 100),
                SizedBox(height: Dimens.appBarFontSize),
                Text(
                  AppLocalizations.of(context).translate('before_proceeding'),
                  style: TextStyle(
                      fontSize: Dimens.titleSize, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: Dimens.spacingSmall),
                Text(
                  AppLocalizations.of(context).translate('singup_message'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Dimens.textSize),
                ),
                SizedBox(height: Dimens.spacingMedium),
                _buildDoneButton()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDoneButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.of(context).pop();
          if (_formKey.currentState!.validate()) {
            String response = await _userStore.registerUser(
                _nameController.text.trim(),
                _emailController.text.trim(),
                _passwordController.text.trim(),
                _inviteCodeController.text.trim(),
                selectedCountry ?? 'USA');
            _showErrorMessage(response);
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
          AppLocalizations.of(context).translate('done'),
          style: AppThemeData.buttonTextStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
