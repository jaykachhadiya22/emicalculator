import 'package:flutter/material.dart';

class AppColors {
  static const Color black100 = Color(0xFF121316);
  static const Color black90 = Color(0xFF171A1E);
  static const Color black80 = Color(0xFF1E2125);
  static const Color black70 = Color(0xFF272B32);
  static const Color black60 = Color(0xFF31363E);
  static const Color black50 = Color(0xFF5A5E65);
  static const Color black40 = Color(0xFF84878C);
  static const Color black30 = Color(0xFFB5B6B9);
  static const Color black20 = Color(0xFFDFDFE1);
  static const Color black10 = Color(0xFFEFEFF0);
  static const Color grey = Color(0xFF84878C);
  static const Color grey100 = Color(0xFF25282B);

  static const Color pink = Color(0xFFFFB9DB);
  static const Color purple = Color(0xFF966EF8);
  static const Color purple100 = Color(0xFF966EF8);

  static const Color orange = Color(0xFFFFA500);
  static const Color yellow = Color(0xFFFFDC01);
  static const Color extraLightYellow = Color(0xFFD6FD70);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color red = Color(0xFFEB5454);
  static const Color error = Color(0xFFF63D3D);
  static const Color success = Color(0xff34B44A);
  static const Color warning = Color(0xffFFC062);
  static const Color lightYellow = Color(0xff2A3126);

  static const Gradient yellowGradient = LinearGradient(
    colors: [Color(0xFFFFDC01), Color(0xFFFA8C01)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient lightYellowGradient = LinearGradient(
    colors: [Color(0xFFFFDC01), Color(0xFFFA8C01)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient gradientTransparent = LinearGradient(
    colors: [
      Color(0x00121316),
      Color(0x80121316),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient gradientBlack = LinearGradient(
    colors: [black, black],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
