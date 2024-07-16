// Package imports:

import 'package:feedvibe/core/hive/hive_box_constants.dart';
import 'package:feedvibe/core/injectable_modules/injection_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

// Project imports:

final di = GetIt.I;

@InjectableInit()
Future<void> configureDeps() async {
  di.init();
  await configureHives();
}

Future<void> configureHives() async {
  await Hive.initFlutter();
  await Hive.openBox<dynamic>(HiveConstants.userBox);
  // await Hive.openBox<dynamic>(HiveConstants.tokenBox);
}
