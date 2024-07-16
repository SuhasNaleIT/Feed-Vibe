// cubit/add_post_cubit.dart
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/data/post/models/post_model.dart';
import 'package:feedvibe/domain/auth/usecases/get_cached_user_usecase.dart';
import 'package:feedvibe/domain/post/usecases/create_post_usecase.dart';
import 'package:feedvibe/presentation/post/cubits/add_post/add_post_state.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit(this.getCachedUserUsecase, this.createPostUsecase)
      : super(const AddPostState());

  // final FirebaseAuth _auth;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetCachedUserUsecase getCachedUserUsecase;
  final CreatePostUsecase createPostUsecase;

  Future<void> addPost() async {
    emit(state.copyWith(isLoading: true));

    final title = state.title;
    final description = state.description;

    final user = await getCachedUserUsecase.call();
    String postId = const Uuid().v1();
    final PostModel postModel = PostModel(
      title: title,
      description: description,
      uid: user.fold((l) => null, (r) => r.id),
      postId: postId,
      username: user.fold((l) => null, (r) => r.username),
      likes: const [],
      comments: const [],
      timestamp: DateTime.now(),
    );
    final result =
        await createPostUsecase(CreatePostParams(postModel: postModel));
    result.fold(
      (Failure failure) => emit(
        state.copyWith(failure: failure, isLoading: false),
      ),
      (String? status) => emit(
        state.copyWith(
          status: status,
          isLoading: false,
        ),
      ),
    );

    // try {
    //   if (title!.isNotEmpty && description!.isNotEmpty) {
    //     await _firestore.collection("posts").doc(postId).set({
    //       'title': title,
    //       'description': description,
    //       'uid': user.fold((l) => null, (r) => r.id),
    //       'postId': postId,
    //       'username': user.fold((l) => null, (r) => r.username),
    //       'likes': [],
    //       'comments': [],
    //       'timestamp': FieldValue.serverTimestamp(),
    //     });
    //     emit(state.copyWith(
    //         isLoading: false, status: 'Post uploaded successfully'));
    //   }
    // } catch (e) {
    //   emit(state.copyWith(status: e.toString()));
    // }
  }

  void updateTitle({required String? title}) {
    emit(state.copyWith(title: title));
  }

  void updateDescription({required String? description}) {
    emit(state.copyWith(description: description));
  }

  void updateErrorMessage(String? errorMessage) {
    emit(state.copyWith(errorMessage: errorMessage));
  }

  void clearState() {
    emit(const AddPostState());
  }

  @override
  void onChange(Change<AddPostState> change) {
    log(change.nextState.toString());
    super.onChange(change);
  }
}
