// Flutter imports:
import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:feedvibe/core/theme/text.dart';
import 'package:flutter/material.dart';

// Project imports:

class AppStyle {
  static double scale = 1;

  /// The current theme colors for the app
  static final AppColors colors = AppColors();

  /// Text styles
  static final Texts text = Texts(scale);

  static void initialize({Size? appSize}) {
    /// Measure the diagonal size of the app window, and slightly adjust
    /// the scale value which is
    /// applied to paddings and font-sizes across the app.
    if (appSize == null) {
      scale = 1;
      return;
    }

    // Add your logic to calculate scale based on appSize
    // For example:
    // final screenSize = (appSize.width + appSize.height) / 2;
    // if (screenSize > 1499) {
    //   scale = 1; // more than or equal to Figma size 1920+1080
    // } else if (screenSize > 1259) {
    //   scale = .9; // desktop 1440+1080
    // } else if (screenSize > 1006) {
    //   scale = .825; // desktop 1366+649
    // } else if (screenSize > 999) {
    //   scale = .775; // iPad air
    // } else if (screenSize > 895) {
    //   scale = .75; // iPad mini
    // } else {
    //   scale = .7; // mobiles
    // }
  }
}
