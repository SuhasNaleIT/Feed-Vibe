// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@module
// @InjectableInit.microPackage()
// initMicroPackage() {}

/// Firebase Injectable Module to inject Firebase libraries via DI
/// (Dependency injection)
abstract class FirebaseInjectableModule
// extends MicroPackageModule
{
  /// Firebase Auth
  @LazySingleton()
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  /// Firebase Firestore
  @LazySingleton()
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  // /// Firebase Messaging
  // /// Firebase Crashlytics
  // @LazySingleton()
  // FirebaseCrashlytics get firebaseCrashlytics => FirebaseCrashlytics.instance;

  // /// Firebase Performance
  // @LazySingleton()
  // FirebasePerformance get firebasePerformance => FirebasePerformance.instance;

  // /// Firebase Analytics
  // @LazySingleton()
  // FirebaseAnalytics get firebaseAnalytics => FirebaseAnalytics.instance;
}
