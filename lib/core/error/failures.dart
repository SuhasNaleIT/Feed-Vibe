// Package imports:
import 'package:equatable/equatable.dart';

/// This [Failure] class is created to reduce propogation
/// of errors such as SocketException to propogate to
/// the UI Layer.This class will hold the exceptions thrown
/// from the [Data Layer]
abstract class Failure extends Equatable {
  /// Failure constructor
  const Failure({this.message});

  final String? message;
  String? get failureMessage => message;
  @override
  List<Object?> get props => <Object?>[message];
}

/// [InternalServerFailure] is returned when API Endpoint
/// returns a 500 Internal Server Error status code
class InternalServerFailure extends Failure {
  const InternalServerFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

/// [OTPFAILURE] is returned when API Endpoint
/// returns a 404 Not Found status code
class OTPFailure extends Failure {}

/// [NotFoundFailure] is returned when API Endpoint
/// returns a 404 Not Found status code
class NotFoundFailure extends Failure {}

/// [ServerUnavailableFailure] is returned when API Endpoint
/// returns a 503 Server unavailable status code
class ServerUnavailableFailure extends Failure {
  const ServerUnavailableFailure(this.errorMessage);

  final String errorMessage;
  @override
  String get message => errorMessage;
}

/// [CacheFailure] is returned when there's
/// no Cache Found in the device
class CacheFailure extends Failure {}

/// [ConflictFailure] is returned when API Endpoint
/// returns a 409 Conflict Status Code
class ConflictFailure extends Failure {
  const ConflictFailure({this.errorMessage = ''});
  final String errorMessage;
  @override
  String get message => errorMessage;
}

/// [RegisterEmailUniqueFailure] is returned when register API Endpoint
/// returns a 409 Conflict Status Code
class RegisterEmailUniqueFailure extends Failure {
  const RegisterEmailUniqueFailure();
}

/// [RegisterPhoneNumberUniqueFailure] is returned when register API Endpoint
/// returns a 409 Conflict Status Code
class RegisterPhoneNumberUniqueFailure extends Failure {
  const RegisterPhoneNumberUniqueFailure();
}

/// [MethodNotAllowedFailure] is returned when API Endpoint
/// returns a 409 Conflict Status Code
class MethodNotAllowedFailure extends Failure {}

///[FormatFailure] is returned when API Endpoint
/// returns a 400 Bad Request Status Code
class FormatFailure extends Failure {}

/// [NoInternetConnectionFailure] is returned when there's
/// no active internet connection
class NoInternetConnectionFailure extends Failure {}

/// [UnauthorizedFailure] is returned when there's
/// there is 401 unauthorized thrown from the API endpoint
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(this.message);
  @override
  final String message;

  @override
  List<Object> get props => [message];
}

/// [ForbiddenFailure] is returned when API Endpoint
/// returns a 403 user Forbidden status code
class ForbiddenFailure extends Failure {
  const ForbiddenFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

/// [CustomMessageFailure] is returned when there's
/// there is  CustomMessage thrown from the API endpoint
class CustomMessageFailure extends Failure {
  const CustomMessageFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

/// [BadRequestFailure] is returned when there's
/// there is 400 CustomMessage thrown from the API endpoint
class BadRequestFailure extends Failure {
  const BadRequestFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

/// [SomethingWentWrongFailure] is returned when there's
/// there is 400 CustomMessage thrown from the API endpoint
class SomethingWentWrongFailure extends Failure {
  const SomethingWentWrongFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

/// [ServerErrorFailure] is returned when there's
/// there is status code >500 and excludes [500,502,503] CustomMessage thrown from the API endpoint
class ServerErrorFailure extends Failure {
  const ServerErrorFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

/// [BadGatewayFailure] is returned when there's
/// there is status code 502 CustomMessage thrown from the API endpoint
class BadGatewayFailure extends Failure {
  const BadGatewayFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

/// [AppNotRespondedAsExpectedFailure] only throw this error
/// when any type error occured while converting data into models
class AppNotRespondedAsExpectedFailure extends Failure {
  // const AppNotRespondedAsExpectedFailure();
  const AppNotRespondedAsExpectedFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message =>
      'App not responded as Expected, Sorry for any inconvenience';
}

/// [ParseJsonFailure] is returned when Response body from API endpoint
/// is unable to be parsed into a dart object
class ParseJsonFailure extends Failure {
  @override
  String get message => 'Failed to parse Data';
}

/// [IsAbusiveWordFailure] is returned when Response body from API endpoint
/// is unable to be parsed into a dart object
class IsAbusiveWordFailure extends Failure {
  @override
  String get message => 'Abusive word in username';
}

class InvalidBankDetailFailure extends Failure {
  const InvalidBankDetailFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

class InvalidBankAccountFailure extends Failure {
  const InvalidBankAccountFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

class InvalidPanCardFailure extends Failure {
  const InvalidPanCardFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

class InvalidPanCardTypeFailure extends Failure {
  const InvalidPanCardTypeFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

class MobileNotLinkedFailure extends Failure {
  const MobileNotLinkedFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

class InvalidAadharCardFailure extends Failure {
  const InvalidAadharCardFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

class InvalidAadharCardDetailsProvidedFailure extends Failure {
  const InvalidAadharCardDetailsProvidedFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

class InvalidPanCardDetailsProvidedFailure extends Failure {
  const InvalidPanCardDetailsProvidedFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

class InvalidAadharCardOtpFailure extends Failure {
  const InvalidAadharCardOtpFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

class AadharCardOtpExpiredFailure extends Failure {
  const AadharCardOtpExpiredFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

class AadharCardOtpSessionExpiredFailure extends Failure {
  const AadharCardOtpSessionExpiredFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

class InsufficiantBalanceToSendOtpFailure extends Failure {
  const InsufficiantBalanceToSendOtpFailure(this.errorMessage);
  final String errorMessage;
  @override
  String get message => errorMessage;
}

class NotEnoughSpotsFailure extends Failure {}

class InsufficientBalanceFailure extends Failure {}

class AadharOTPAlreadySentFailure extends Failure {}

//******* Firebase Failures */

/// Firebase Auth Log in Failures
class FirebaseAuthLogInFailedFailure extends Failure {}

class FirebaseAuthLogInInvalidEmailFailure extends Failure {}

class FirebaseAuthLogInUserDisabledFailure extends Failure {}

class FirebaseAuthLogInUserNotFoundFailure extends Failure {}

class FirebaseAuthLogInWrongPasswordFailure extends Failure {}

class FirebaseAuthLogInUnknownFailure extends Failure {}

class FirebaseAuthLogInTooManyRequestsFailure extends Failure {}

class FirebaseAuthLogInInvalidCredentialsFailure extends Failure {}

class FirebaseAuthForgetPasswordUserNotFoundFailure extends Failure {}

class FirebaseAuthForgetPasswordUnknownFailure extends Failure {}

class FirebaseAuthForgetPasswordNoInternetFailure extends Failure {}

class FirebaseAuthNetworkRequestFailedFailure extends Failure {}

/// Sign up Firebase error

class FirebaseAuthSignUpInvalidEmailFailure extends Failure {
  const FirebaseAuthSignUpInvalidEmailFailure();
  @override
  List<Object?> get props => <Object?>[];
}

class FirebaseAuthSignUpUserDisabledFailure extends Failure {
  const FirebaseAuthSignUpUserDisabledFailure();
  @override
  List<Object?> get props => <Object?>[];
}

class FirebaseAuthSignUpUserNotFoundFailure extends Failure {
  const FirebaseAuthSignUpUserNotFoundFailure();
  @override
  List<Object?> get props => <Object?>[];
}

class FirebaseAuthSignUpEmailAlreadyInUseFailure extends Failure {
  const FirebaseAuthSignUpEmailAlreadyInUseFailure();
  @override
  List<Object?> get props => <Object?>[];
}

class FirebaseAuthSignUpOperationNotAllowedFailure extends Failure {
  const FirebaseAuthSignUpOperationNotAllowedFailure();
  @override
  List<Object?> get props => <Object?>[];
}

class FirebaseAuthSignUpWeakPasswordFailure extends Failure {
  const FirebaseAuthSignUpWeakPasswordFailure();
  @override
  List<Object?> get props => <Object?>[];
}

class FirebaseAuthSignUpNetworkRequestFailedFailure extends Failure {
  const FirebaseAuthSignUpNetworkRequestFailedFailure();
  @override
  List<Object?> get props => <Object?>[];
}

class FirebaseAuthSignUpUnknownSignUpFailure extends Failure {
  const FirebaseAuthSignUpUnknownSignUpFailure();
  @override
  List<Object?> get props => <Object?>[];
}
