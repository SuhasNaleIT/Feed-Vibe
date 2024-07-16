// Flutter imports:
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/domain/auth/usecases/signup_with_email_password.dart';
import 'package:feedvibe/presentation/auth/cubits/signup/signup_state.dart';
import 'package:feedvibe/presentation/auth/cubits/signup/user_data_holder.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:

@injectable
class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.signupWithEmailAndPasswordUsecase)
      : super(const SignupState());

  final SignupWithEmailAndPasswordUsecase signupWithEmailAndPasswordUsecase;

  UserDataHolder userDataHolder = UserDataHolder();

  Future<void> signupWithEmailAndPassword() async {
    emit(
      state.copyWith(isLoading: true),
    );

    final result = await signupWithEmailAndPasswordUsecase(SignupParams(
      userDataHolder: UserDataHolder(
        emailAddress:
            state.emailAddress != null && state.emailAddress!.isNotEmpty
                ? state.emailAddress
                : null,
        userName: state.userName != null && state.userName!.isNotEmpty
            ? state.userName
            : null,
        bio: state.bio != null && state.bio!.isNotEmpty ? state.bio : null,
        password: state.password != null && state.password!.isNotEmpty
            ? state.password
            : null,
      ),
    ));

    result.fold(
      (Failure failure) {
        debugPrint('we got a failure budddy: $failure');
        emit(
          state.copyWith(
            failure: failure,
            isLoading: false,
          ),
        );
      },
      (String status) {
        emit(
          state.copyWith(
            status: status,
            isLoading: false,
          ),
        );
      },
    );
  }

  void updateFailure() {
    emit(
      state.copyWith(
        // ignore: avoid_redundant_argument_values
        failure: null,
      ),
    );
  }

  void updateErrorMessage({required String errorMessage}) {
    emit(state.copyWith(errorMessage: errorMessage));
  }

  void updateEmailErrorMessage({required String emailErrorMessage}) {
    emit(state.copyWith(emailErrorMessage: emailErrorMessage));
  }

  void updatePasswordErrorMessage({required String passwordErrorMessage}) {
    emit(state.copyWith(passwordErrorMessage: passwordErrorMessage));
  }

  void updateConfirmPasswordErrorMessage({
    required String confirmPasswordMessage,
  }) {
    emit(state.copyWith(confirmPasswordMessage: confirmPasswordMessage));
  }

  void updateShowPassword({required bool showPassword}) {
    emit(state.copyWith(showPassword: showPassword));
  }

  void updateShowConfirmPassword({required bool showConfirmPassword}) {
    emit(state.copyWith(showConfirmPassword: showConfirmPassword));
  }

  void updateUsernameErrorMessage({required String usernameErrorMessage}) {
    emit(state.copyWith(usernameErrorMessage: usernameErrorMessage));
  }

  void updateEmail({required String? emailValue}) {
    emit(state.copyWith(emailAddress: emailValue));
  }

  void updateUserName({required String? userName}) {
    emit(state.copyWith(userName: userName));
  }

  void updatePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  void updateConfirmPassword({required String confirmPassword}) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void updateBio({required String? bio}) {
    emit(state.copyWith(bio: bio));
  }

  void clearState() {
    emit(const SignupState());
  }

  @override
  void onChange(Change<SignupState> change) {
    debugPrint(change.nextState.toString());
    super.onChange(change);
  }
}
