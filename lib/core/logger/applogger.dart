// Package imports:
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

abstract class AppLogger {
  ///trace log
  void t(
    Type className,
    String message,
  );

  ///debug log
  void d(
    Type className,
    String message,
  );

  ///info log
  void i(
    Type className,
    String message,
  );

  ///warning log
  void w(
    Type className,
    String message,
  );

  ///error log
  void e(
    Type className,
    String message, {
    dynamic error,
  });

  ///fatal log
  void f(
    Type className,
    String message, {
    dynamic error,
    StackTrace? stackTrace,
  });
}

@LazySingleton(as: AppLogger)
class AppLoggerImpl implements AppLogger {
  AppLoggerImpl({required this.logger});
  // : logger = logger ??
  //       Logger(
  //         printer: PrettyPrinter(
  //           // noBoxingByDefault: true,
  //           // excludeBox: {
  //           //   Level.info: true,
  //           // },
  //           stackTraceBeginIndex: 1, //to skip the AppLoggerImpl method
  //           // errorMethodCount: 0,
  //           lineLength: 80,
  //           methodCount: 0,
  //           levelEmojis: {
  //             Level.info: '👻',
  //           },
  //         ),
  //       );
  final Logger logger;

  @override
  void t(Type className, String message) {
    logger.t('$className - $message');
  }

  @override
  void d(Type className, String message) {
    logger.d('$className - $message');
  }

  @override
  void i(Type className, String message) {
    logger.i('$className - $message');
  }

  @override
  void w(Type className, String message) {
    logger.w('$className - $message');
  }

  @override
  void e(Type className, String message, {dynamic error}) {
    logger.e(
      '$className - $message',
      error: error,
    );
  }

  @override
  void f(
    Type className,
    String message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    logger.f(
      '$className - $message',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
