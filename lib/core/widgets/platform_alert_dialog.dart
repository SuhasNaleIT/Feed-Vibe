// Dart imports:
import 'dart:io';

// Project imports:

// Flutter imports:
import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Show Platform Alert Dialog
Future<bool?> showPlatformAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String defaultActionText,
  // ignore: inference_failure_on_function_return_type
  Function()? defaultAction,
  // ignore: inference_failure_on_function_return_type
  Function()? cancelAction,
  String? cancelActionText,
  bool isDestructiveActionIOS = false,
  TextStyle? cancelActionTextStyle,
}) async {
  if (kIsWeb || !Platform.isIOS) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        surfaceTintColor: AppColors.whiteColor,
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (cancelActionText != null)
            TextButton(
              child: Text(cancelActionText, style: cancelActionTextStyle),
              onPressed: () => cancelAction ?? Navigator.of(context).pop(false),
            ),
          TextButton(
            child: Text(defaultActionText),
            onPressed: () => defaultAction ?? Navigator.of(context).pop(true),
          ),
        ],
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            onPressed: cancelAction ?? () => Navigator.of(context).pop(false),
            child: Text(
              cancelActionText,
              style: cancelActionTextStyle,
            ),
          ),
        CupertinoDialogAction(
          onPressed: () => defaultAction ?? Navigator.of(context).pop(true),
          isDestructiveAction: isDestructiveActionIOS,
          child: Text(defaultActionText),
        ),
      ],
    ),
  );
}
