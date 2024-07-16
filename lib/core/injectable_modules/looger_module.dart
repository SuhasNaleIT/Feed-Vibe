// Package imports:
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class LoggerInjectableModule {
  @LazySingleton()
  Logger get logger => Logger(
        printer: PrettyPrinter(
          // noBoxingByDefault: true,
          // excludeBox: {
          //   Level.info: true,
          // },
          stackTraceBeginIndex: 1, //to skip the AppLoggerImpl method
          methodCount: 0,
          levelEmojis: {
            Level.info: '👻',
          },
        ),
      );
}
