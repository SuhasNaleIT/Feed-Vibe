import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AppUserEntity extends Equatable {
  const AppUserEntity({
    this.id,
    this.username,
    this.bio,
    this.email,
    this.password,
  });

  final String? id;
  final String? username;
  final String? bio;
  final String? email;
  final String? password;

  static const empty = AppUserEntity(
    id: '',
  );

  bool get isEmpty => this == AppUserEntity.empty;

  bool get isNotEmpty => this != AppUserEntity.empty;

  @override
  List<Object?> get props => <Object?>[id, username, email, password];

  @override
  String toString() {
    return 'AppUserEntity { '
        'id: $id, '
        'username: $username, '
        'bio: $bio, '
        'emailAddress: $email, '
        'password: $password, '
        ' }';
  }
}
