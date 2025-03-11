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
  final double size;


  const CircularButtonWithLabel({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.borderColor = AppThemeData.primaryColor,
    this.iconColor = AppThemeData.primaryColor,
    this.size= Dimens.buttonCircularSize,
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
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Center(
              child: Icon(icon, color: iconColor, size: Dimens.defaultLogoSize),
            ),
          ),
        ),
        label==''?SizedBox():
        SizedBox(height: Dimens.spacingSmall),
        label==''?SizedBox():
        Text(
          AppLocalizations.of(context).translate(label),
          style: TextStyle(
              fontSize: Dimens.fontSmall, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
