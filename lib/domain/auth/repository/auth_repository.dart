import 'package:dartz/dartz.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/data/auth/models/app_user_model.dart';
import 'package:feedvibe/domain/auth/entities/app_user_entity.dart';
import 'package:feedvibe/presentation/auth/cubits/signup/user_data_holder.dart';

abstract class AuthRepository {
  AppUserEntity userFromFirebase(AppUserModel? user);

  Future<Either<Failure, AppUserEntity>> signInWithEmailAndPassword({
    required String? email,
    required String? password,
  });

  Future<Either<Failure, String>> signupWithEmailAndPassword({
    required UserDataHolder userDataHolder,
  });

  Future<Either<Failure, AppUserEntity>> getUserFromCache();

  Future<void> invalidateAppUserCacheData();
}
