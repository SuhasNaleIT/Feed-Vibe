import 'package:dartz/dartz.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/core/usecase/usecase_with_either.dart';
import 'package:feedvibe/data/post/models/comment_model.dart';
import 'package:feedvibe/domain/post/repository/post_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CreateCommentUsecase
    implements UsecaseWithEither<String, CreateCommentParams> {
  CreateCommentUsecase(this.postRepository);
  final PostRepository postRepository;

  @override
  Future<Either<Failure, String>> call(CreateCommentParams params) async {
    return postRepository.createComment(
      commentModel: params.commentModel,
    );
  }
}

class CreateCommentParams {
  CreateCommentParams({
    required this.commentModel,
  });

  final CommentModel commentModel;
}
