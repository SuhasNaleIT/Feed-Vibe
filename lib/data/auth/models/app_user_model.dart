// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:feedvibe/domain/auth/entities/app_user_entity.dart';

class AppUserModel extends AppUserEntity {
  const AppUserModel({
    super.id,
    super.username,
    super.bio,
    super.email,
    super.password,
  });

  static const empty = AppUserModel();

  @override
  bool get isEmpty => this == AppUserModel.empty;

  @override
  bool get isNotEmpty => this != AppUserModel.empty;

  // fromJson
  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      id: json['id'] as String?,
      username: json['userName'] as String?,
      bio: json['bio'] as String?,
      email: json['emailAddress'] as String?,
      password: json['password'] as String?,
    );
  }

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': username,
      'bio': bio,
      'emailAddress': email,
      'password': password,
    };
  }
}
