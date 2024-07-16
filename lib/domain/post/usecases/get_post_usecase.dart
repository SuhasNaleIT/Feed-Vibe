// Package imports:
import 'package:dartz/dartz.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/core/usecase/usecase_with_either.dart';
import 'package:feedvibe/domain/post/entities/post_entity.dart';
import 'package:feedvibe/domain/post/repository/post_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetPostUsecase implements UsecaseWithEither<List<PostEntity>, void> {
  GetPostUsecase({required this.postRepository});

  final PostRepository postRepository;
  @override
  Future<Either<Failure, List<PostEntity>>> call([
    void params,
  ]) {
    return postRepository.getPost();
  }
}
