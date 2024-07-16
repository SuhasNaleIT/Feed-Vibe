import 'package:dartz/dartz.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/core/usecase/usecase_with_either.dart';
import 'package:feedvibe/domain/auth/repository/auth_repository.dart';
import 'package:feedvibe/presentation/auth/cubits/signup/user_data_holder.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SignupWithEmailAndPasswordUsecase
    implements UsecaseWithEither<String, SignupParams> {
  SignupWithEmailAndPasswordUsecase(this.authRepository);
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, String>> call(SignupParams params) async {
    return authRepository.signupWithEmailAndPassword(
      userDataHolder: params.userDataHolder
    );
  }
}

class SignupParams {
  SignupParams({
    required this.userDataHolder
  });

  final UserDataHolder userDataHolder;
}
