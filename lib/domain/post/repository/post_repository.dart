import 'package:dartz/dartz.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/data/post/models/comment_model.dart';
import 'package:feedvibe/data/post/models/post_model.dart';
import 'package:feedvibe/domain/post/entities/post_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, String>> createPost({
    required PostModel postModel,
  });

  Future<Either<Failure, List<PostEntity>>> getPost();

    Future<Either<Failure, String>> createComment({
    required CommentModel commentModel,
  });
}
