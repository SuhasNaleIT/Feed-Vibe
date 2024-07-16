import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/core/logger/applogger.dart';
import 'package:feedvibe/data/post/datasources/post_remote_datasource.dart';
import 'package:feedvibe/data/post/models/comment_model.dart';
import 'package:feedvibe/data/post/models/post_model.dart';
import 'package:feedvibe/domain/post/entities/post_entity.dart';
import 'package:feedvibe/domain/post/repository/post_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImplementation implements PostRepository {
  PostRepositoryImplementation(
    this.appLogger,
    this.postRemoteDataSource,
  );

  final AppLogger appLogger;
  final PostRemoteDataSource postRemoteDataSource;

  @override
  Future<Either<Failure, String>> createPost({
    required PostModel postModel,
  }) async {
    try {
      final String? status = await postRemoteDataSource.createPost(
        postModel: postModel,
      );
      return Right<Failure, String>(status!);
    } on SocketException {
      return Left<Failure, String>(
        NoInternetConnectionFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPost() async {
    try {
      final posts = await postRemoteDataSource.getPost();

      return Right<Failure, List<PostEntity>>(posts!);
    } on SocketException {
      return Left<Failure, List<PostEntity>>(
        NoInternetConnectionFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, String>> createComment({
    required CommentModel commentModel,
  }) async {
    try {
      final String? status = await postRemoteDataSource.createComment(
        commentModel: commentModel,
      );
      return Right<Failure, String>(status!);
    } on SocketException {
      return Left<Failure, String>(
        NoInternetConnectionFailure(),
      );
    }
  }
}
