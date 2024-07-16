// Package imports:

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:feedvibe/core/error/failures.dart';

/// Use this class as a interface for the
/// [Future<<Either,Type>>] returning usecases
// ignore: one_member_abstracts
abstract class UsecaseWithEither<Type, Params> {
  /// [Type] is the return type whereas [Params] are
  /// the arguments/parameters
  Future<Either<Failure, Type>> call(Params params);
}
