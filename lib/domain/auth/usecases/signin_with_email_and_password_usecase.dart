import 'package:dartz/dartz.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/core/usecase/usecase_with_either.dart';
import 'package:feedvibe/domain/auth/entities/app_user_entity.dart';
import 'package:feedvibe/domain/auth/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SignInWithEmailAndPasswordUsecase
    implements UsecaseWithEither<AppUserEntity, SignInParams> {
  SignInWithEmailAndPasswordUsecase(this.authRepository);
  final AuthRepository authRepository;
  // final AuthRepo authRepo;

  @override
  Future<Either<Failure, AppUserEntity>> call(SignInParams params) async {
    return authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams {
  SignInParams({required this.email, required this.password});
  final String? email;
  final String? password;
}
