// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

class SingleTapDetector extends StatelessWidget {
  SingleTapDetector({
    required this.child,
    required this.onButtonPressed,
    super.key,
    this.interval = 1000,
  });
  final Widget child;
  final int interval;
  final VoidCallback onButtonPressed;
  bool isClicked = false;
  late Timer timer;

  void _startTimer() {
    timer = Timer(Duration(milliseconds: interval), () => isClicked = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isClicked == false) {
          _startTimer();
          onButtonPressed();
          isClicked = true;
        }
      },
      child: child,
    );
  }
}
