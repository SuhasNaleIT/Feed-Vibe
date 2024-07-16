part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email,
    this.password,
    this.failure,
    this.appUserEntity,
    this.isLoading = false,
    this.emailErrorMessage,
    this.passwordErrorMessage,
    this.showPassword = true,
    this.showConfirmPassword,
  });

  final String? email;
  final String? password;
  final Failure? failure;
  final AppUserEntity? appUserEntity;
  final bool isLoading;

  //Error Messages
  final String? emailErrorMessage;
  final String? passwordErrorMessage;
  final bool showPassword;
  final bool? showConfirmPassword;

  LoginState copyWith({
    String? email,
    String? password,
    Failure? failure,
    AppUserEntity? appUserEntity,
    bool? isLoading,
    String? emailErrorMessage,
    String? passwordErrorMessage,
    bool? showPassword,
    bool? showConfirmPassword,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      failure: failure ?? this.failure,
      appUserEntity: appUserEntity ?? this.appUserEntity,
      isLoading: isLoading ?? this.isLoading,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
    );
  }

  @override
  String toString() {
    return 'LoginState(email: $email, isLoading: $isLoading, password: $password, failure: $failure, user: $appUserEntity )';
  }

  @override
  List<Object?> get props => [
        email,
        password,
        failure,
        appUserEntity,
        isLoading,
        emailErrorMessage,
        passwordErrorMessage,
        showPassword,
        showConfirmPassword,
      ];
}
