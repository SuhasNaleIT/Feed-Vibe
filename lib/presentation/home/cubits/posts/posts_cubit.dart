// posts_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/domain/post/entities/post_entity.dart';
import 'package:feedvibe/domain/post/usecases/get_post_usecase.dart';
import 'package:injectable/injectable.dart';

part 'posts_state.dart';

@injectable
class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.getPostUsecase) : super(PostsInitial());

  // final FirebaseFirestore _firestore;
  final GetPostUsecase getPostUsecase;

  Future<void> fetchPosts() async {
    emit(PostsLoading());

    //  final String? jwtToken = await getJWTToken.authRepository.getJWTToken();
    // if (jwtToken != null) {
    final response =
        // await getAllNotificationUsecase.call();
        await getPostUsecase();

    if (!isClosed) {
      response.fold(
        (Failure failure) {
          emit(PostsError(failure: failure));
        },
        (List<PostEntity> posts) => emit(PostsLoaded(posts: posts)),
      );
    }
  }
}
