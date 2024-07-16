import 'dart:convert';
import 'dart:developer';

import 'package:feedvibe/core/exceptions/exceptions.dart';
import 'package:feedvibe/core/hive/hive_box_constants.dart';
import 'package:feedvibe/data/auth/models/app_user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:injectable/injectable.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheAppUserDetails({
    required AppUserModel user,
  });

  Future<AppUserModel> getCachedAppUser();

  Future<void> invalidateUserDetailsFromCache();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({
    required this.hive,
  });
  final HiveInterface hive;

  @override
  Future<void> cacheAppUserDetails({required AppUserModel user}) async {
    debugPrint('Data to cache of user: $user');
    final jsonData = json.encode(user.toJson());
    debugPrint('JSON Data to cache of user: $jsonData');

    try {
      final userBox = Hive.isBoxOpen(HiveConstants.userBox)
          ? Hive.box<dynamic>(HiveConstants.userBox)
          : await Hive.openBox<dynamic>(HiveConstants.userBox);

      await userBox.put(HiveConstants.userBoxKey, jsonData);
    } catch (e) {
      debugPrint('Error in Auth local data source $e');
    }
  }

  @override
  Future<AppUserModel> getCachedAppUser() async {
    try {
      final box = Hive.isBoxOpen(HiveConstants.userBox)
          ? Hive.box<dynamic>(HiveConstants.userBox)
          : await Hive.openBox<dynamic>(HiveConstants.userBox);

      final jsonString = box.get(HiveConstants.userBoxKey) as String?;

      debugPrint('User JSON String: $jsonString');

      if (jsonString != null) {
        final userMap = json.decode(jsonString) as Map<String, dynamic>;
        debugPrint('User Map: $userMap');
        final user = AppUserModel.fromJson(userMap);
        debugPrint('User in Auth local data source $user');
        return user;
      } else {
        throw CacheException();
      }
    } catch (e) {
      debugPrint('Error in Auth local data source $e');
      throw CacheException();
    }
  }

  @override
  Future<void> invalidateUserDetailsFromCache() async {
    try {
      final box = Hive.isBoxOpen(HiveConstants.userBox)
          ? Hive.box<dynamic>(HiveConstants.userBox)
          : await Hive.openBox<dynamic>(HiveConstants.userBox);
      final tokenBox = Hive.isBoxOpen(HiveConstants.tokenBox)
          ? Hive.box<dynamic>(HiveConstants.tokenBox)
          : await Hive.openBox<dynamic>(HiveConstants.tokenBox);
      await tokenBox.clear();
      await box.clear();
      await Hive.deleteFromDisk();

      log('User details cleared from cache');
    } catch (e) {
      log('Error invalidating user details from cache: $e');
    }
  }
}
