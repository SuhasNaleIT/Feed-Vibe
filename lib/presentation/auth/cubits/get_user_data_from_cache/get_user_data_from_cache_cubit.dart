// Flutter imports:
import 'dart:developer';

import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/domain/auth/entities/app_user_entity.dart';
import 'package:feedvibe/domain/auth/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

// Project imports:

part 'get_user_data_from_cache_state.dart';

@injectable
class GetUserDataFromCacheCubit extends Cubit<GetUserDataFromCacheState> {
  GetUserDataFromCacheCubit(this.repository)
      : super(GetUserDataFromCacheInitial());

  final AuthRepository repository;

  Future<void> getUserFromCache() async {
    // emit(
    //   GetUserDataFromCacheLoading(),
    // );
    final result = await repository.getUserFromCache();
    log('Result: $result');
    result.fold(
      (Failure failure) {
        debugPrint('User not received cache into Cubit');
        emit(
          GetUserDataFromCacheError(
            failure: failure,
          ),
        );
      },
      (AppUserEntity appUser) {
        log('Got User from cache into Cubit $appUser');
        emit(
          GetUserDataFromCacheLoaded(
            appUser: appUser,
          ),
        );
      },
    );
  }

  Future<void> clearCache() async {
    await repository.invalidateAppUserCacheData();
    emit(
      GetUserDataFromCacheError(
        failure: CacheFailure(),
      ),
    );
  }
}
