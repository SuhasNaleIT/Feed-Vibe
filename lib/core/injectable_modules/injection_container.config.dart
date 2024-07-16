// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i7;
import 'package:feedvibe/core/injectable_modules/firebase_injectable_module.dart'
    as _i31;
import 'package:feedvibe/core/injectable_modules/hive_module.dart' as _i29;
import 'package:feedvibe/core/injectable_modules/looger_module.dart' as _i30;
import 'package:feedvibe/core/logger/applogger.dart' as _i8;
import 'package:feedvibe/data/auth/datasources/auth_local_data_source.dart'
    as _i10;
import 'package:feedvibe/data/auth/datasources/auth_remote_datasource.dart'
    as _i13;
import 'package:feedvibe/data/auth/repository_implementation/auth_repository_implementation.dart'
    as _i17;
import 'package:feedvibe/data/post/datasources/post_remote_datasource.dart'
    as _i9;
import 'package:feedvibe/data/post/repository_implementation/post_repository_implementation.dart'
    as _i12;
import 'package:feedvibe/domain/auth/repository/auth_repository.dart' as _i16;
import 'package:feedvibe/domain/auth/usecases/get_cached_user_usecase.dart'
    as _i18;
import 'package:feedvibe/domain/auth/usecases/signin_with_email_and_password_usecase.dart'
    as _i24;
import 'package:feedvibe/domain/auth/usecases/signup_with_email_password.dart'
    as _i25;
import 'package:feedvibe/domain/post/repository/post_repository.dart' as _i11;
import 'package:feedvibe/domain/post/usecases/create_comment_usecase.dart'
    as _i15;
import 'package:feedvibe/domain/post/usecases/create_post_usecase.dart' as _i14;
import 'package:feedvibe/domain/post/usecases/get_post_usecase.dart' as _i21;
import 'package:feedvibe/presentation/auth/cubits/get_user_data_from_cache/get_user_data_from_cache_cubit.dart'
    as _i22;
import 'package:feedvibe/presentation/auth/cubits/login/login_cubit.dart'
    as _i26;
import 'package:feedvibe/presentation/auth/cubits/signup/signup_cubit.dart'
    as _i27;
import 'package:feedvibe/presentation/bottom_navigation_bar/cubits/index_holder_cubit.dart'
    as _i3;
import 'package:feedvibe/presentation/home/cubits/add_comment/add_comment_cubit.dart'
    as _i23;
import 'package:feedvibe/presentation/home/cubits/posts/posts_cubit.dart'
    as _i28;
import 'package:feedvibe/presentation/post/cubits/add_post/add_post_cubit.dart'
    as _i19;
import 'package:feedvibe/presentation/profile/cubits/my_posts/my_posts_cubit.dart'
    as _i20;
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/hive_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final hiveInjectableModule = _$HiveInjectableModule();
    final loggerInjectableModule = _$LoggerInjectableModule();
    final firebaseInjectableModule = _$FirebaseInjectableModule();
    gh.factory<_i3.PageIndexHolderCubit>(() => _i3.PageIndexHolderCubit());
    gh.lazySingleton<_i4.HiveInterface>(() => hiveInjectableModule.hive);
    gh.lazySingleton<_i5.Logger>(() => loggerInjectableModule.logger);
    gh.lazySingleton<_i6.FirebaseAuth>(
        () => firebaseInjectableModule.firebaseAuth);
    gh.lazySingleton<_i7.FirebaseFirestore>(
        () => firebaseInjectableModule.firestore);
    gh.lazySingleton<_i8.AppLogger>(
        () => _i8.AppLoggerImpl(logger: gh<_i5.Logger>()));
    gh.singleton<_i9.PostRemoteDataSource>(() => _i9.PostRemoteDataSource(
          gh<_i8.AppLogger>(),
          firebaseAuth: gh<_i6.FirebaseAuth>(),
        ));
    gh.lazySingleton<_i10.AuthLocalDataSource>(
        () => _i10.AuthLocalDataSourceImpl(hive: gh<_i4.HiveInterface>()));
    gh.lazySingleton<_i11.PostRepository>(
        () => _i12.PostRepositoryImplementation(
              gh<_i8.AppLogger>(),
              gh<_i9.PostRemoteDataSource>(),
            ));
    gh.singleton<_i13.AuthRemoteDataSource>(() => _i13.AuthRemoteDataSource(
          gh<_i8.AppLogger>(),
          gh<_i10.AuthLocalDataSource>(),
          firebaseAuth: gh<_i6.FirebaseAuth>(),
        ));
    gh.lazySingleton<_i14.CreatePostUsecase>(
        () => _i14.CreatePostUsecase(gh<_i11.PostRepository>()));
    gh.lazySingleton<_i15.CreateCommentUsecase>(
        () => _i15.CreateCommentUsecase(gh<_i11.PostRepository>()));
    gh.lazySingleton<_i16.AuthRepository>(
        () => _i17.AuthRepositoryImplementation(
              gh<_i8.AppLogger>(),
              gh<_i10.AuthLocalDataSource>(),
              gh<_i13.AuthRemoteDataSource>(),
            ));
    gh.lazySingleton<_i18.GetCachedUserUsecase>(
        () => _i18.GetCachedUserUsecase(repository: gh<_i16.AuthRepository>()));
    gh.factory<_i19.AddPostCubit>(() => _i19.AddPostCubit(
          gh<_i18.GetCachedUserUsecase>(),
          gh<_i14.CreatePostUsecase>(),
        ));
    gh.factory<_i20.MyPostsCubit>(() => _i20.MyPostsCubit(
          gh<_i7.FirebaseFirestore>(),
          gh<_i18.GetCachedUserUsecase>(),
        ));
    gh.lazySingleton<_i21.GetPostUsecase>(
        () => _i21.GetPostUsecase(postRepository: gh<_i11.PostRepository>()));
    gh.factory<_i22.GetUserDataFromCacheCubit>(
        () => _i22.GetUserDataFromCacheCubit(gh<_i16.AuthRepository>()));
    gh.factory<_i23.AddCommentCubit>(() => _i23.AddCommentCubit(
          gh<_i18.GetCachedUserUsecase>(),
          gh<_i15.CreateCommentUsecase>(),
        ));
    gh.lazySingleton<_i24.SignInWithEmailAndPasswordUsecase>(() =>
        _i24.SignInWithEmailAndPasswordUsecase(gh<_i16.AuthRepository>()));
    gh.lazySingleton<_i25.SignupWithEmailAndPasswordUsecase>(() =>
        _i25.SignupWithEmailAndPasswordUsecase(gh<_i16.AuthRepository>()));
    gh.factory<_i26.LoginCubit>(
        () => _i26.LoginCubit(gh<_i24.SignInWithEmailAndPasswordUsecase>()));
    gh.factory<_i27.SignupCubit>(
        () => _i27.SignupCubit(gh<_i25.SignupWithEmailAndPasswordUsecase>()));
    gh.factory<_i28.PostsCubit>(
        () => _i28.PostsCubit(gh<_i21.GetPostUsecase>()));
    return this;
  }
}

class _$HiveInjectableModule extends _i29.HiveInjectableModule {}

class _$LoggerInjectableModule extends _i30.LoggerInjectableModule {}

class _$FirebaseInjectableModule extends _i31.FirebaseInjectableModule {}
