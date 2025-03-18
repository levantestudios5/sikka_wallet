import 'package:flutter/material.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/assets.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/presentation/registration/signup_screen.dart';
import 'package:sikka_wallet/utils/locale/app_localization.dart';
import 'package:sikka_wallet/utils/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppThemeData.baseGradient),
        padding: const EdgeInsets.all(Dimens.screenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              Assets.splashIcon,
              height: size.height * Dimens.logoHeightFactor,
            ),
            const Spacer(),
            _buildLogoTextRow(size),
            const SizedBox(height: Dimens.textSpacing),
            _buildSubtitle(size),
            const SizedBox(height: Dimens.textSpacing),
            _buildGetStartedButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoTextRow(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.splashIcon,
          height: size.height * Dimens.smallLogoHeightFactor,
        ),
        const SizedBox(width: Dimens.iconSpacing),
        Text(
          (AppLocalizations.of(context).translate('app_name')),
          style: AppThemeData.titleStyle,
        ),
      ],
    );
  }

  Widget _buildSubtitle(Size size) {
    return SizedBox(
      width: size.width * Dimens.subtitleWidthFactor,
      child: Text(
        (AppLocalizations.of(context).translate('splash_subtitle')),
        textAlign: TextAlign.center,
        style: AppThemeData.subtitleStyle,
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.signUp);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: Dimens.buttonPadding),
        ),
        child: Text(
          (AppLocalizations.of(context).translate('get_started')),
          style: AppThemeData.buttonTextStyle,
        ),
      ),
    );
  }
}
