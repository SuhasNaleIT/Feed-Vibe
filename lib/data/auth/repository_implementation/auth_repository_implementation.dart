import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/core/exceptions/exceptions.dart';
import 'package:feedvibe/core/logger/applogger.dart';
import 'package:feedvibe/data/auth/datasources/auth_local_data_source.dart';
import 'package:feedvibe/data/auth/datasources/auth_remote_datasource.dart';
import 'package:feedvibe/data/auth/models/app_user_model.dart';
import 'package:feedvibe/domain/auth/entities/app_user_entity.dart';
import 'package:feedvibe/domain/auth/repository/auth_repository.dart';
import 'package:feedvibe/presentation/auth/cubits/signup/user_data_holder.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImplementation implements AuthRepository {
  AuthRepositoryImplementation(
    this.appLogger,
    this.authLocalDataSource,
    this.authRemoteDataSource,
  );

  final AuthLocalDataSource authLocalDataSource;
  final AppLogger appLogger;
  final AuthRemoteDataSource authRemoteDataSource;
  // final FtsAuthenticationRepository ftsAuthenticationRepository;

  @override
  Future<Either<Failure, AppUserEntity>> signInWithEmailAndPassword({
    required String? email,
    required String? password,
  }) async {
    try {
      final AppUserModel? user =
          await authRemoteDataSource.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('Logged in from firebase, now getting data from user : $user');

      return Right<Failure, AppUserEntity>(user!);
    } on FirebaseAuthLogInInvalidEmailException {
      return Left<Failure, AppUserEntity>(
        FirebaseAuthLogInInvalidEmailFailure(),
      );
    } on FirebaseAuthLogInUserDisabledException {
      return Left<Failure, AppUserEntity>(
        FirebaseAuthLogInUserDisabledFailure(),
      );
    } on FirebaseAuthLogInUserNotFoundException {
      return Left<Failure, AppUserEntity>(
        FirebaseAuthLogInUserNotFoundFailure(),
      );
    } on FirebaseAuthLogInWrongPasswordException {
      return Left<Failure, AppUserEntity>(
        FirebaseAuthLogInWrongPasswordFailure(),
      );
    } on FirebaseAuthLogInUnknownException {
      return Left<Failure, AppUserEntity>(
        FirebaseAuthLogInUnknownFailure(),
      );
    } on FirebaseAuthLogInTooManyRequestsException {
      return Left<Failure, AppUserEntity>(
        FirebaseAuthLogInTooManyRequestsFailure(),
      );
    } on FirebaseAuthLogInInvalidCredentialsException {
      return Left<Failure, AppUserEntity>(
        FirebaseAuthLogInInvalidCredentialsFailure(),
      );
    } on FirebaseAuthNetworkRequestFailedException {
      return Left<Failure, AppUserEntity>(
        FirebaseAuthNetworkRequestFailedFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, String>> signupWithEmailAndPassword({
    required UserDataHolder userDataHolder,
  }) async {
    try {
      final user = await authRemoteDataSource.signupWithEmailAndPassword(
          userDataHolder: userDataHolder);
      // final appUser = userFromFirebase(user);
      return Right<Failure, String>(user!);
    } on FirebaseAuthSignUpInvalidEmailException {
      return const Left<Failure, String>(
        FirebaseAuthSignUpInvalidEmailFailure(),
      );
    } on FirebaseAuthSignUpUserDisabledException {
      return const Left<Failure, String>(
        FirebaseAuthSignUpUserDisabledFailure(),
      );
    } on FirebaseAuthSignUpEmailAlreadyInUseException {
      return const Left<Failure, String>(
        FirebaseAuthSignUpEmailAlreadyInUseFailure(),
      );
    } on FirebaseAuthSignUpNetworkRequestFailedException {
      return Left<Failure, String>(
        FirebaseAuthNetworkRequestFailedFailure(),
      );
    } on SocketException {
      return Left<Failure, String>(
        NoInternetConnectionFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, AppUserEntity>> getUserFromCache() async {
    try {
      final user = await authLocalDataSource.getCachedAppUser();
      debugPrint('user data recieved from backend  getCachedAppUser:$user');
      return Right<Failure, AppUserEntity>(user);
    } on CacheException {
      return Left<Failure, AppUserEntity>(
        CacheFailure(),
      );
    }
  }

  @override
  Future<void> invalidateAppUserCacheData() async {
    await authLocalDataSource.invalidateUserDetailsFromCache();
  }

  @override
  AppUserEntity userFromFirebase(AppUserModel? user) {
    return user == null
        ? AppUserEntity.empty
        : AppUserEntity(
            id: user.id,
            email: user.email,
          );
  }
}
