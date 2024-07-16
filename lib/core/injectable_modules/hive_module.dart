// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@module

/// Hive Injectable Module to inject [HiveInterface] via DI
/// (Dependency injection)
abstract class HiveInjectableModule {
  /// Hive Library
  @LazySingleton()
  HiveInterface get hive => Hive;
}
