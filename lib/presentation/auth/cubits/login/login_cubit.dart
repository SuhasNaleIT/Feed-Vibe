import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/domain/auth/entities/app_user_entity.dart';
import 'package:feedvibe/domain/auth/usecases/signin_with_email_and_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
    this.signInWithEmailAndPasswordUsecase,
  ) : super(const LoginState());

  final SignInWithEmailAndPasswordUsecase signInWithEmailAndPasswordUsecase;

  Future<void> loginWithEmailAndPassowrd() async {
    emit(state.copyWith(isLoading: true));
    final result = await signInWithEmailAndPasswordUsecase(
        SignInParams(email: state.email, password: state.password));
    result.fold(
      (Failure failure) => emit(
        state.copyWith(failure: failure, isLoading: false),
      ),
      (AppUserEntity appUserEntity) => emit(
        state.copyWith(
          appUserEntity: appUserEntity,
          isLoading: false,
        ),
      ),
    );
  }

  void updateEmail({required String email}) {
    emit(state.copyWith(email: email));
  }

  void updatePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  void updateEmailErrorMessage({required String emailErrorMessage}) {
    emit(state.copyWith(emailErrorMessage: emailErrorMessage));
  }

  void updatePasswordErrorMessage({required String passwordErrorMessage}) {
    emit(state.copyWith(passwordErrorMessage: passwordErrorMessage));
  }

  void updateShowPassword({required bool showPassword}) {
    emit(state.copyWith(showPassword: showPassword));
  }

  void updateShowConfirmPassword({required bool showConfirmPassword}) {
    emit(state.copyWith(showConfirmPassword: showConfirmPassword));
  }

  void updateFailure({required Failure? failure}) {
    emit(state.copyWith(failure: failure));
  }

  void clearState() {
    emit(const LoginState());
  }

  @override
  void onChange(Change<LoginState> change) {
    debugPrint(change.nextState.toString());
    super.onChange(change);
  }
}
