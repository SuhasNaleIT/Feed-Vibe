// Flutter imports:
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF007BCD);
  static const Color primaryBGColor = Color(0xFF000000);
  static const Color primaryColorOne = Color(0xFFDA873C);
  static const Color redButtonColor = Color(0xFFD10101);
  static const Color purpleColor = Color(0xFF673AB7);

  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Color(0xFF6C7278);
  static const Color darkGreyColor = Color(0xFF686868);
  static const Color lightGreyColor = Color(0xFFBABABA);
  static const Color lightestGreyColor = Color(0xFFD9D9D9);

  static const Color secondaryColor = Color(0xFF0C393F);
  static const Color cardBGColor = Color(0xFF135B63);
  static const Color offWhite = Color.fromARGB(255, 255, 252, 252);
  static const Color indicatorColor = Color(0xFF049CA1);
  static const Color indicatorBorderColor = Color(0xFF16555D);
  static const Color turquoise = Color(0xFF49D1d6);
  static const Color failureRedColor = Color(0xFFEC4040);
  static const Color lightestTurquoise = Color.fromRGBO(4, 156, 161, 0.1);

  static const Color lightTurquoise = Color.fromARGB(8, 77, 149, 151);
  static const Color onboardingTitleColor = Color(0xFF2B2B2B);
  static const Color onboardingButtonColor = Color(0xFFF0C042);
  static Color lightGreyOpacity50 = const Color(0xFFE3E3E3).withOpacity(0.5);

  static const Color creditMoneyColor = Color(0xFF13A63B);
  static const Color creditMoneyLightColor = Color(0xFFE2FEE8);

  static const Color lightGreenColor = Color(0xFF51BF2C);

  // static const Color creditMoneyColor = Color(0xFF13A63B);
  // static const Color creditMoneyLightColor = Color(0xFFE2FEE8);

  // static const Color lightGreenColor = Color(0xFF51BF2C);

  static const Color textUnderlineGreen = Color(0xFF007F6B);
  static const Color snackbarBackgroundColor = Color(0xFF0C393F);
  static const Color snackbarTextColor = Color(0xFFF8FEFF);
  static const Color darkGreenColor = Color(0xFF2A4B51);

  static const Color transparent = Colors.transparent;

  static const Color lightGrey = Color(0xFFBABABA);
  // static const Color red = Colors.red;

  static const LinearGradient background = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color.fromRGBO(198, 246, 255, 0.1),
      Color.fromRGBO(
        217,
        239,
        243,
        99,
      ),
    ],
  );

  static LinearGradient filterLinearGradient = LinearGradient(
    colors: [
      const Color.fromRGBO(42, 75, 81, 1),
      const Color(0xFF0DDAFF).withOpacity(0.42),
    ],
  );

  static LinearGradient yellowLinearGradient = LinearGradient(
    colors: [
      const Color.fromRGBO(240, 192, 66, 0),
      const Color.fromRGBO(240, 192, 66, 0).withOpacity(0.42),
    ],
  );

  static LinearGradient tealLinearGradient = const LinearGradient(
    colors: [
      Color.fromRGBO(58, 144, 207, 0),
      Color.fromRGBO(58, 144, 207, 0.29),
      Color.fromRGBO(166, 207, 236, 0),
    ],
  );

  static LinearGradient blueLinearGradient = LinearGradient(
    colors: [
      const Color.fromRGBO(58, 144, 207, 0),
      const Color.fromRGBO(58, 144, 207, 0).withOpacity(0.42),
    ],
  );

  static LinearGradient redLinearGradient = const LinearGradient(
    colors: [
      Color.fromRGBO(236, 64, 64, 0),
      Color.fromRGBO(236, 64, 64, 0.44),
    ],
  );

  static LinearGradient posterLinearGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(31, 149, 165, 1),
      Color.fromRGBO(0, 0, 0, 1),
    ],
  );

  static LinearGradient onbordingGradient = const LinearGradient(
    begin: Alignment.center,
    end: Alignment.center,
    colors: [
      Color.fromRGBO(12, 57, 63, 1),
      Colors.white,
    ],
  );

  static const Color rankDownArrowColor = Color(0xFFE20E0E);

  static const Color midTurquoise = Color(0xFFEFFFFD);
}
