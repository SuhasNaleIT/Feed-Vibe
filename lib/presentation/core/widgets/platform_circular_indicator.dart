// Dart imports:
import 'dart:io';

// Flutter imports:
// Project imports:
import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:feedvibe/presentation/core/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformCircularProgressIndicator extends PlatformWidget {
  const PlatformCircularProgressIndicator({this.color, super.key});

  final Color? color;
  @override
  Widget buildCupertinoWidget(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(
        color: color,
      );
    } else {
      return CupertinoActivityIndicator(
        color: color,
      );
    }
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    if (kIsWeb || !Platform.isIOS) {
      return CircularProgressIndicator(
        backgroundColor: color,
        color: AppColors.lightestGreyColor,
      );
    } else {
      return CircularProgressIndicator(
        backgroundColor: color,
        color: AppColors.lightestGreyColor,
      );
    }
  }
}
