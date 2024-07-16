part of 'get_user_data_from_cache_cubit.dart';

sealed class GetUserDataFromCacheState extends Equatable {
  const GetUserDataFromCacheState();

  @override
  List<Object> get props => [];
}

final class GetUserDataFromCacheInitial extends GetUserDataFromCacheState {}

final class GetUserDataFromCacheLoading extends GetUserDataFromCacheState {}

final class GetUserDataFromCacheLoaded extends GetUserDataFromCacheState {
  const GetUserDataFromCacheLoaded({
    required this.appUser,
  });

  final AppUserEntity? appUser;
}

final class GetUserDataFromCacheError extends GetUserDataFromCacheState {
  const GetUserDataFromCacheError({
    required this.failure,
  });

  final Failure failure;
}
