import 'package:feedvibe/app/view/app.dart';
import 'package:feedvibe/core/injectable_modules/injection_container.dart';
import 'package:feedvibe/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureDeps();
  runApp(const App());
}
