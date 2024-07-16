// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class PlatformWidget extends StatelessWidget {
  const PlatformWidget({super.key});

  /// Builds Material Widget
  Widget buildMaterialWidget(BuildContext context);

  /// Builds Cupertino Widget
  Widget buildCupertinoWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildCupertinoWidget(context);
    }
    if (kIsWeb || !Platform.isIOS) {
      return buildMaterialWidget(context);
    }
    return buildMaterialWidget(context);
  }
}
