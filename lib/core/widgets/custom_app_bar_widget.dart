import 'package:flutter/material.dart';
import 'package:sikka_wallet/constants/assets.dart';
import 'package:sikka_wallet/constants/colors.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/core/widgets/custom_circular_button.dart';
import 'package:sikka_wallet/presentation/home/bottom_nav_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNotificationPressed;
  final VoidCallback onProfilePressed;

  const CustomAppBar({
    Key? key,
    required this.onNotificationPressed,
    required this.onProfilePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:Color(0xFFA455F8),
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                Assets.splashIcon,
                height: 20,
              ),
              SizedBox(width: Dimens.inputSpacing),
              Text(
                context.translate("app_name"),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              CircularButtonWithLabel(
                icon: Icons.notifications_none_outlined,
                iconColor: Colors.white,
                size: 40,
                borderColor: Colors.white,
                backgroundColor: Colors.transparent,
                onPressed: onNotificationPressed,
                label: '',
              ),
              SizedBox(width: Dimens.paddingSmall),
              CircularButtonWithLabel(
                icon: Icons.person_3_outlined,
                size: 40,
                iconColor: Colors.white,
                borderColor: Colors.white,
                backgroundColor: Colors.transparent,
                onPressed: onProfilePressed,
                label: '',
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
