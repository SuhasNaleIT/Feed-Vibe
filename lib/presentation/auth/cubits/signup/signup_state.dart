// Package imports:
import 'package:equatable/equatable.dart';
import 'package:feedvibe/core/error/failures.dart';

// Project imports:

class SignupState extends Equatable {
  const SignupState({
    this.emailAddress,
    this.userName,
    this.bio,
    this.password,
    this.confirmPassword,
    this.failure,
    this.errorMessage,
    this.usernameErrorMessage,
    this.emailErrorMessage,
    this.passwordErrorMessage,
    this.confirmPasswordMessage,
    this.showPassword = true,
    this.showConfirmPassword = true,
    this.isLoading = false,
    this.status,
  });

  final String? emailAddress;
  final String? userName;
  final String? bio;
  final String? password;
  final String? confirmPassword;
  final Failure? failure;
  final String? errorMessage;
  final String? usernameErrorMessage;
  final String? emailErrorMessage;
  final String? passwordErrorMessage;
  final String? confirmPasswordMessage;
  final bool showPassword;
  final bool showConfirmPassword;
  final bool isLoading;

  final String? status;

  //Page Index
  // final AppUserEntity? appUserEntity;

  @override
  String toString() {
    return '''
    SignupState(
      emailAddress: $emailAddress, userName: $userName,  bio: $bio, password: $password, confirmPassword: $confirmPassword,
       failure: $failure, errorMessage: $errorMessage, usernameErrorMessage: $usernameErrorMessage, emailErrorMessage: $emailErrorMessage,
        passwordErrorMessage: $passwordErrorMessage, confirmPasswordMessage: $confirmPasswordMessage, showPassword: $showPassword, showConfirmPassword: $showConfirmPassword,
        isLoading: $isLoading, status: $status)''';
  }

  SignupState copyWith({
    String? emailAddress,
    String? userName,
    String? bio,
    String? password,
    String? confirmPassword,
    Failure? failure,
    String? errorMessage,
    String? usernameErrorMessage,
    String? emailErrorMessage,
    String? passwordErrorMessage,
    String? confirmPasswordMessage,
    bool? showPassword,
    bool? showConfirmPassword,
    bool? isLoading,
    String? status,
  }) {
    return SignupState(
      emailAddress: emailAddress ?? this.emailAddress,
      userName: userName ?? this.userName,
      bio: bio ?? this.bio,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
      usernameErrorMessage: usernameErrorMessage ?? this.usernameErrorMessage,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      confirmPasswordMessage:
          confirmPasswordMessage ?? this.confirmPasswordMessage,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailAddress': emailAddress,
      'userName': userName,
      'bio': bio,
      'password': password,
      'confirmPassword': confirmPassword,
      'failure': failure,
      'errorMessage': errorMessage,
      'usernameErrorMessage': usernameErrorMessage,
      'emailErrorMessage': emailErrorMessage,
      'passwordErrorMessage': passwordErrorMessage,
      'confirmPasswordMessage': confirmPasswordMessage,
      'showPassword': showPassword,
      'showConfirmPassword': showConfirmPassword,
      'isLoading': isLoading,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [
        emailAddress,
        userName,
        bio,
        password,
        confirmPassword,
        failure,
        errorMessage,
        usernameErrorMessage,
        emailErrorMessage,
        passwordErrorMessage,
        confirmPasswordMessage,
        showPassword,
        showConfirmPassword,
        isLoading,
        status,
      ];
}
