import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Text(
          message,
          style:
              const TextStyle(fontSize: 16, color: AppColors.snackbarTextColor),
        ),
      ],
    ),
    backgroundColor: AppColors.primaryBGColor,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.all(16),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
