import 'package:flutter/material.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/utils/locale/app_localization.dart';

class CircularButtonWithLabel extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color borderColor;
  final String label;
  final Color iconColor;
  final Color backgroundColor;

  const CircularButtonWithLabel({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.borderColor = AppThemeData.primaryColor,
    this.iconColor = AppThemeData.primaryColor,
    this.backgroundColor = Colors.white,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(Dimens.buttonCircularSize),
          child: Container(
            width: Dimens.buttonCircularSize,
            height: Dimens.buttonCircularSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              border: Border.all(color: borderColor, width: Dimens.borderWidth),
            ),
            child: Center(
              child: Icon(icon, color: iconColor, size: Dimens.defaultLogoSize),
            ),
          ),
        ),
        SizedBox(height: Dimens.spacingSmall),
        Text(
          AppLocalizations.of(context).translate(label),
          style: TextStyle(
              fontSize: Dimens.fontSmall, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
