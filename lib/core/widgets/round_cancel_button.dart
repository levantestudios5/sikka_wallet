import 'package:flutter/material.dart';

class RoundCancelButton extends StatelessWidget {
  final VoidCallback callbackAction;

  RoundCancelButton({super.key, required this.callbackAction});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => this.callbackAction,
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        side: const BorderSide(width: 2.0, color: Colors.grey),
        padding: const EdgeInsets.all(16.0),
      ),
      child: const Icon(
        Icons.close, // Cross icon
        color: Colors.black,
        size: 24.0,
      ),
    );
  }
}
