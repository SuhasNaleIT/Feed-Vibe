/// [NotFoundException] is thrown when API Endpoint
/// returns a 500 Internal Server Error Status Code
class InternalServerException implements Exception {}

/// [NotFoundException] is thrown when API Endpoint
/// returns a 404 Not Found Status Code
class NotFoundException implements Exception {}

/// [ServerUnavailableException] is thrown when API Endpoint
/// returns a 503 Server Unavailable Status Code
class ServerUnavailableException implements Exception {}

/// [FormatException] is thrown when API Endpoint
/// returns a 400 Bad Request Status Code
class FormatException implements Exception {}

/// [ConflictException] is thrown when API Endpoint
/// returns a 409 Conflict Status Code
class ConflictException implements Exception {}

/// [CacheException] is thrown when there's
/// no Cache Found in the device
class CacheException implements Exception {}

/// [ParseJsonException] is thrown when there's
/// parse json error
class ParseJsonException implements Exception {}

/// [NoInternetConnectionException] is thrown when there's
/// no active internet connection
class NoInternetConnectionException implements Exception {}

/// [TimeoutException] is thrown when there's
/// Gateway Time-out
class TimeoutException implements Exception {}

/// [ForbiddenException] is thrown when there's
/// no active internet connection
class ForbiddenException implements Exception {
  ForbiddenException(this.errorMessage);
  final String errorMessage;
  String get meesage => errorMessage;
}

/// [SomethingWentWrongException] is thrown something went wrong
/// something went wrong
class SomethingWentWrongException implements Exception {
  SomethingWentWrongException(this.errorMessage);
  final String errorMessage;
  String get meesage => errorMessage;
}

/// [BadRequestException] is thrown when backend return 400
class BadRequestException implements Exception {
  BadRequestException(this.errorMessage);
  final String errorMessage;
  String get meesage => errorMessage;
}

/// [UnauthorizedException] is thrown when backend return 400
class UnauthorizedException implements Exception {
  UnauthorizedException(this.errorMessage);
  final String errorMessage;
  String get meesage => errorMessage;
}

/// [SocketConnectionNotInitializedException] should be call only
/// when you try to call get channel before initializing channel
class SocketConnectionNotInitializedException implements Exception {
  SocketConnectionNotInitializedException(this._errorMessage);
  final String _errorMessage;
  String get meesage => _errorMessage;
}

/// [AppNotRespondedAsExpectedException] should be call only
/// when you try to call get channel before initializing channel
class AppNotRespondedAsExpectedException implements Exception {
  AppNotRespondedAsExpectedException(this._errorMessage);
  final String _errorMessage;
  String get meesage => _errorMessage;
}

/// [MethodNotAllowedException] should be call only
/// when you try to call get channel before initializing channel
class MethodNotAllowedException implements Exception {
  MethodNotAllowedException(this._errorMessage);
  final String _errorMessage;
  String get meesage => _errorMessage;
}

/// [EmailUniqueException] should be call only
/// when you try to call get channel before initializing channel
class EmailUniqueException implements Exception {
  EmailUniqueException(this._errorMessage);
  final String _errorMessage;
  String get meesage => _errorMessage;
}

/// [PhoneNumberUniqueException] should be call only
/// when you try to call get channel before initializing channel
class PhoneNumberUniqueException implements Exception {
  PhoneNumberUniqueException(this._errorMessage);
  final String _errorMessage;
  String get meesage => _errorMessage;
}

class NotEnoughSpotsException implements Exception {}

class InsufficientBalanceException implements Exception {}

//**************** Firebase Exceptions **************/

/// Thrown during the login process if an exception occurs.
class FirebaseAuthLogInException implements Exception {
  /// Create a login exception with the given [message].
  const FirebaseAuthLogInException([
    this.message = 'An unknown exception occurred.',
  ]);

  /// The associated error message.
  final String message;
}

/// Exception for invalid email format during login.
class FirebaseAuthLogInInvalidEmailException
    extends FirebaseAuthLogInException {
  /// Create an exception for an invalid email during login.
  const FirebaseAuthLogInInvalidEmailException()
      : super('Email is not valid or badly formatted.');
}

/// Exception for a disabled user during login.
class FirebaseAuthLogInUserDisabledException
    extends FirebaseAuthLogInException {
  /// Create an exception for a disabled user during login.
  const FirebaseAuthLogInUserDisabledException()
      : super('This user has been disabled. Please contact support for help.');
}

/// Exception for a user not found during login.
class FirebaseAuthLogInUserNotFoundException
    extends FirebaseAuthLogInException {
  /// Create an exception for a user not found during login.
  const FirebaseAuthLogInUserNotFoundException()
      : super('Email is not found, please create an account.');
}

/// Exception for an incorrect password during login.
class FirebaseAuthLogInWrongPasswordException
    extends FirebaseAuthLogInException {
  /// Create an exception for an incorrect password during login.
  const FirebaseAuthLogInWrongPasswordException()
      : super('Incorrect password, please try again.');
}

/// Exception for too many requests during login.
class FirebaseAuthLogInTooManyRequestsException
    extends FirebaseAuthLogInException {
  /// Create an exception for an incorrect password during login.
  const FirebaseAuthLogInTooManyRequestsException()
      : super('Too Many requests, please try again later.');
}

/// Exception for too many requests during login.
class FirebaseAuthLogInInvalidCredentialsException
    extends FirebaseAuthLogInException {
  /// Create an exception for an incorrect password during login.
  const FirebaseAuthLogInInvalidCredentialsException()
      : super('Invalid Credentials, please try again later.');
}

/// Exception for an unknown error during login.
class FirebaseAuthLogInUnknownException extends FirebaseAuthLogInException {
  /// Create an exception for an unknown error during login.
  const FirebaseAuthLogInUnknownException()
      : super('An unknown exception occurred.');
}

/// Exception for an network request failed during login.
// ignore: lines_longer_than_80_chars
class FirebaseAuthNetworkRequestFailedException
    extends FirebaseAuthLogInException {
  /// Create an exception for an unknown error during login.
  const FirebaseAuthNetworkRequestFailedException()
      : super('No Internet connection available');
}

/// Exception for if Firebase throw null user
class FirebaseAuthLogInFailedException extends FirebaseAuthLogInException {
  const FirebaseAuthLogInFailedException() : super('Unable to Log In user.');
}

/// Class for handling login exceptions.
class FirebaseAuthLogInExceptionManager {
  /// Create an authentication message from a Firebase
  /// authentication exception code.
  static void logInExceptionFromCode(String code) {
    switch (code.toLowerCase()) {
      case 'invalid-email':
        throw const FirebaseAuthLogInInvalidEmailException();
      case 'user-disabled':
        throw const FirebaseAuthLogInUserDisabledException();
      case 'user-not-found':
        throw const FirebaseAuthLogInUserNotFoundException();
      case 'wrong-password':
        throw const FirebaseAuthLogInWrongPasswordException();
      case 'too-many-requests':
        throw const FirebaseAuthLogInTooManyRequestsException();
      case 'invalid_login_credentials':
        throw const FirebaseAuthLogInInvalidCredentialsException();
      case 'invalid-credential':
        throw const FirebaseAuthLogInInvalidCredentialsException();
      case 'network-request-failed':
        throw const FirebaseAuthNetworkRequestFailedException();
      default:
        throw const FirebaseAuthLogInUnknownException();
    }
  }
}

/// Thrown during the sign-up process if an exception occurs.
class FirebaseAuthSignUpWithEmailAndPasswordException implements Exception {
  /// Create a sign-up exception with the given [message].
  const FirebaseAuthSignUpWithEmailAndPasswordException(this.message);

  /// The associated error message.
  final String message;
}

/// Create an authentication message
/// from a firebase authentication exception code.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html

/// Thrown if the email is not valid or badly formatted.
class FirebaseAuthSignUpInvalidEmailException
    extends FirebaseAuthSignUpWithEmailAndPasswordException {
  /// Create an exception for an invalid email.
  const FirebaseAuthSignUpInvalidEmailException()
      : super('Email is not valid or badly formatted.');
}

/// Thrown if the user has been disabled.
class FirebaseAuthSignUpUserDisabledException
    extends FirebaseAuthSignUpWithEmailAndPasswordException {
  /// Create an exception for a disabled user.
  const FirebaseAuthSignUpUserDisabledException()
      : super('This user has been disabled. Please contact support for help.');
}

/// Thrown if the email is already in use.
class FirebaseAuthSignUpEmailAlreadyInUseException
    extends FirebaseAuthSignUpWithEmailAndPasswordException {
  /// Create an exception for an email that is already in use.
  const FirebaseAuthSignUpEmailAlreadyInUseException()
      : super('An account already exists for that email.');
}

/// Thrown if the operation is not allowed.
class FirebaseAuthSignUpOperationNotAllowedException
    extends FirebaseAuthSignUpWithEmailAndPasswordException {
  /// Create an exception for an operation that is not allowed.
  const FirebaseAuthSignUpOperationNotAllowedException()
      : super(
          'Operation is not allowed. Please contact support.',
        );
}

/// Thrown if the password is too weak.
class FirebaseAuthSignUpWeakPasswordException
    extends FirebaseAuthSignUpWithEmailAndPasswordException {
  /// Create an exception for a weak password.
  const FirebaseAuthSignUpWeakPasswordException()
      : super(
          'Please enter a stronger password.',
        );
}

/// Thrown for unknown exceptions during sign-up.
class FirebaseAuthSignUpUnknownSignUpException
    extends FirebaseAuthSignUpWithEmailAndPasswordException {
  /// Create an exception for an unknown error during sign-up.
  const FirebaseAuthSignUpUnknownSignUpException()
      : super(
          'An unknown exception occurred.',
        );
}

/// Thrown for network reuest failure during sign-up.
class FirebaseAuthSignUpNetworkRequestFailedException
    extends FirebaseAuthSignUpWithEmailAndPasswordException {
  /// Create an exception for an unknown error during sign-up.
  const FirebaseAuthSignUpNetworkRequestFailedException()
      : super(
          'No Internet connection available',
        );
}

/// Class for handling sign-up exceptions.
class FirebaseAuthSignUpExceptionManager {
  /// Create an authentication message from a Firebase authentication exception
  /// code.
  static void signUpExceptionFromCode(String code) {
    switch (code.toLowerCase()) {
      case 'invalid-email':
        throw const FirebaseAuthSignUpInvalidEmailException();
      case 'user-disabled':
        throw const FirebaseAuthSignUpUserDisabledException();
      case 'email-already-in-use':
        throw const FirebaseAuthSignUpEmailAlreadyInUseException();
      case 'operation-not-allowed':
        throw const FirebaseAuthSignUpOperationNotAllowedException();
      case 'weak-password':
        throw const FirebaseAuthSignUpWeakPasswordException();
      case 'network-request-failed':
        throw const FirebaseAuthSignUpNetworkRequestFailedException();
      default:
        throw const FirebaseAuthSignUpUnknownSignUpException();
    }
  }
}
