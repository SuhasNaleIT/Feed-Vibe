// cubit/add_post_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/data/post/models/comment_model.dart';
import 'package:feedvibe/domain/auth/usecases/get_cached_user_usecase.dart';
import 'package:feedvibe/domain/post/usecases/create_comment_usecase.dart';
import 'package:feedvibe/presentation/home/cubits/add_comment/add_comment_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddCommentCubit extends Cubit<AddCommentState> {
  AddCommentCubit(this.getCachedUserUsecase, this.createCommentUsecase)
      : super(const AddCommentState());

  final GetCachedUserUsecase getCachedUserUsecase;
  final CreateCommentUsecase createCommentUsecase;

  Future<void> addComment({required String postId}) async {
    emit(state.copyWith(isLoading: true));

    final comment = state.comment;

    final user = await getCachedUserUsecase.call();

    final CommentModel commentModel = CommentModel(
      uid: user.fold((l) => null, (r) => r.id),
      username: user.fold((l) => null, (r) => r.username),
      comment: comment,
      postId: postId,
      timestamp: DateTime.now(),
    );
    final result = await createCommentUsecase(
        CreateCommentParams(commentModel: commentModel));
    result.fold(
      (Failure failure) => emit(
        state.copyWith(failure: failure, isLoading: false),
      ),
      (String status) => emit(
        state.copyWith(
          status: status,
          isLoading: false,
        ),
      ),
    );
    emit(state.copyWith(comment: ''));
  }

  void updateComment({required String? comment}) {
    emit(state.copyWith(comment: comment));
  }

  void updateErrorMessage(String? errorMessage) {
    emit(state.copyWith(errorMessage: errorMessage));
  }

  void clearState() {
    emit(const AddCommentState());
  }

  @override
  void onChange(Change<AddCommentState> change) {
    debugPrint(change.nextState.toString());
    super.onChange(change);
  }
}
