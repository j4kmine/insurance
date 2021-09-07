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

  static const Color primaryColor = const Color(0xFF4473C5);
  static const Color darkBlueColor = const Color(0xFF0B3065);
  static const Color secondaryColor = const Color(0xFFFEBF08);
  static const Color defaultColor = const Color(0xFFE3E3E3);
  static const Color boxcolor = const Color(0xFF535353);
  static const Color selectedColor = const Color(0xFFF8F8F8);
  static const Color descriptionColor = const Color(0xFF828282);
  static const Color dangerColor = const Color(0xFFEB5757);
  static const Color greyColor = const Color(0xFF4F4F4F);
  static const Color successColor = const Color(0xFF27AE60);
  static const Color lightBlueColor = const Color(0xFF8EACDB);
}
