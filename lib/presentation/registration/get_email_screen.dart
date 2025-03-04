import 'package:flutter/material.dart';
import 'package:sikka_wallet/core/widgets/custom_elevated_button.dart';
import 'package:sikka_wallet/core/widgets/custom_textfield_widget.dart';
import 'package:sikka_wallet/core/widgets/round_cancel_button.dart';

class GetEmailScreen extends StatefulWidget {
  const GetEmailScreen({super.key});

  @override
  State<GetEmailScreen> createState() => _GetEmailScreenState();
}

class _GetEmailScreenState extends State<GetEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundCancelButton(
            callbackAction: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          Text(
            'Enter your email address',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextFieldWidget(
            hintText: 'Enter email address here',
          ),
          Spacer(),
          CustomElevatedButton(title: "Continue", onPressed: (){
            //todo call API here and navigate to other screen from here
          }),
        ],
      ),
    );
  }
}
