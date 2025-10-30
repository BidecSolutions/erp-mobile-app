import 'package:flutter/material.dart';

class AppFonts {
  // Font Family
  static const String satoshi = 'Satoshi';

  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;

  // Text Styles
  static TextStyle get heading => const TextStyle(
        fontFamily: satoshi,
        fontWeight: bold,
        fontSize: 20,
        color: Colors.black,
      );

  static TextStyle get subHeading => const TextStyle(
        fontFamily: satoshi,
        fontWeight: medium,
        fontSize: 16,
        color: Colors.black,
      );

  static TextStyle get body => const TextStyle(
        fontFamily: satoshi,
        fontWeight: regular,
        fontSize: 14,
        color: Colors.black,
      );

  static TextStyle get lightText => const TextStyle(
        fontFamily: satoshi,
        fontWeight: light,
        fontSize: 12,
        color: Colors.grey,
      );
}
