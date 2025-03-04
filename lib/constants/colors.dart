import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static const Map<int, Color> orange = const <int, Color>{
    50: const Color(0xFFFCF2E7),
    100: const Color(0xFFF8DEC3),
    200: const Color(0xFFF3C89C),
    300: const Color(0xFFEEB274),
    400: const Color(0xFFEAA256),
    500: const Color(0xFFE69138),
    600: const Color(0xFFE38932),
    700: const Color(0xFFDF7E2B),
    800: const Color(0xFFDB7424),
    900: const Color(0xFFD56217)
  };

  static const Map<int, Color> deepPurple = const <int, Color>{
    50: const Color(0xFFEDE0F9),
    100: const Color(0xFFD2B3F2),
    200: const Color(0xFFB380EB),
    300: const Color(0xFF944DE3),
    400: const Color(0xFF7D26DE),
    500: const Color(0xFF6700D6),
    600: const Color(0xFF5F00CB),
    700: const Color(0xFF5400BD),
    800: const Color(0xFF4A00AF),
    900: const Color(0xFF390094),
  };

}
