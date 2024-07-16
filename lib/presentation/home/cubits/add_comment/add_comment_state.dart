// cubit/post_state.dart
import 'package:equatable/equatable.dart';
import 'package:feedvibe/core/error/failures.dart';

class AddCommentState extends Equatable {
  const AddCommentState({
    this.comment,
    this.failure,
    this.errorMessage,
    this.isLoading = false,
    this.status,
  });

  final String? comment;
  final Failure? failure;
  final String? errorMessage;
  final bool isLoading;
  final String? status;

  @override
  String toString() {
    return '''
    AddCommentState(
      comment: $comment,
      failure: $failure,
      errorMessage: $errorMessage,
      isLoading: $isLoading,
      status: $status)''';
  }

  AddCommentState copyWith({
    String? comment,
    Failure? failure,
    String? errorMessage,
    bool? isLoading,
    String? status,
  }) {
    return AddCommentState(
      comment: comment ?? this.comment,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        comment,
        failure,
        errorMessage,
        isLoading,
        status,
      ];
}
