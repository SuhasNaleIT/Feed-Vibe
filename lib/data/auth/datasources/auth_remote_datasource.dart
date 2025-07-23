import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedvibe/core/exceptions/exceptions.dart';
import 'package:feedvibe/core/logger/applogger.dart';
import 'package:feedvibe/data/auth/datasources/auth_local_data_source.dart';
import 'package:feedvibe/data/auth/models/app_user_model.dart';
import 'package:feedvibe/presentation/auth/cubits/signup/user_data_holder.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@Singleton()
class AuthRemoteDataSource {
  AuthRemoteDataSource(
    this.appLogger,
    this.authLocalDataSource, {
    // required this.api,
    // required this.client,
    required this.firebaseAuth,
  });

  // final API api;
  // final http.Client client;
  final firebase_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthLocalDataSource authLocalDataSource;
  final AppLogger appLogger;


  //* Sign in
 
  Future<AppUserModel?> logInWithEmailAndPassword({
    required String? email,
    required String? password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      appLogger.i(AuthRemoteDataSource,
          'Firebase toUser after login ${credential.user}');

      DocumentSnapshot doc =
          await _firestore.collection('users').doc(credential.user!.uid).get();
      appLogger.i(AuthRemoteDataSource, 'get User after login ${doc.data()}');

      final user = AppUserModel.fromJson(doc.data() as Map<String, dynamic>);

      appLogger.i(AuthRemoteDataSource, 'User after model map $user');
      await authLocalDataSource.cacheAppUserDetails(
        user: user,
      );
      return user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      // throw LogInWithEmailAndPasswordException.fromCode(e.code);
      debugPrint('Fts Auth Log In Firebase Error Code ${e.code}');
      FirebaseAuthLogInExceptionManager.logInExceptionFromCode(e.code);
    } catch (e, st) {
      appLogger.e(
          AuthRemoteDataSource, 'Fts Auth Log In Unknown error: $e and $st');
      throw const FirebaseAuthLogInUnknownException();
    }
    return null;
  }

  //* Create new user 

  Future<String?> signupWithEmailAndPassword({
    required UserDataHolder userDataHolder,
  }) async {
    try {
      final credentail = await firebaseAuth.createUserWithEmailAndPassword(
        email: userDataHolder.emailAddress!,
        password: userDataHolder.password!,
      );
      appLogger.i(
          AuthRemoteDataSource, 'Response after Signup ${credentail.user}');

      UserDataHolder userData = UserDataHolder(
          id: credentail.user!.uid,
          emailAddress: credentail.user!.email,
          userName: userDataHolder.userName,
          bio: userDataHolder.bio);
      //Add Data to Firestore
      _firestore
          .collection("users")
          .doc(credentail.user!.uid)
          .set(userData.toJson());

      return credentail.user!.uid.toString();
      // return credentail.user!.toUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      debugPrint('Fts Auth Sign up Firebase Error Code ${e.code}');
      FirebaseAuthSignUpExceptionManager.signUpExceptionFromCode(e.code);
    } catch (e, st) {
      debugPrint('Fts Auth Sign Up Unknown error: $e and $st');
      throw const FirebaseAuthSignUpUnknownSignUpException();
    }
    return null;
  }
}

// extension on firebase_auth.User {
//   /// Maps a [firebase_auth.User] into a [User].
//   User get toUser {
//     return User(id: uid, email: email, username: displayName, password: '');
//   }
// }
