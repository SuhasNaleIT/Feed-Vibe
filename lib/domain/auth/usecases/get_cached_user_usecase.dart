import 'package:dartz/dartz.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/core/usecase/usecase_with_either.dart';
import 'package:feedvibe/domain/auth/entities/app_user_entity.dart';
import 'package:feedvibe/domain/auth/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';


@LazySingleton()
class GetCachedUserUsecase implements UsecaseWithEither<AppUserEntity, void> {
  GetCachedUserUsecase({required this.repository});

  final AuthRepository repository;

  @override
  Future<Either<Failure, AppUserEntity>> call([void params]) {
    return repository.getUserFromCache();
  }
}
