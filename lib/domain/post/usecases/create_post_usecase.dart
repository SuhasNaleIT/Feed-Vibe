import 'package:dartz/dartz.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/core/usecase/usecase_with_either.dart';
import 'package:feedvibe/data/post/models/post_model.dart';
import 'package:feedvibe/domain/post/repository/post_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CreatePostUsecase implements UsecaseWithEither<String, CreatePostParams> {
  CreatePostUsecase(this.postRepository);
  final PostRepository postRepository;

  @override
  Future<Either<Failure, String>> call(CreatePostParams params) async {
    return postRepository.createPost(
      postModel: params.postModel,

    );
  }
}

class CreatePostParams {
  CreatePostParams({
    required this.postModel,

  });

  final PostModel postModel;
}
