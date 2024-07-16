// cubit/post_state.dart
import 'package:equatable/equatable.dart';
import 'package:feedvibe/core/error/failures.dart';

class AddPostState extends Equatable {
  const AddPostState({
    this.title,
    this.description,
    this.failure,
    this.errorMessage,
    this.isLoading = false,
    this.status,
  });

  final String? title;
  final String? description;
  final Failure? failure;
  final String? errorMessage;
  final bool isLoading;
  final String? status;

  @override
  String toString() {
    return '''
    AddPostState(
      title: $title,
      description: $description,
      failure: $failure,
      errorMessage: $errorMessage,
      isLoading: $isLoading,
      status: $status)''';
  }

  AddPostState copyWith({
    String? title,
    String? description,
    Failure? failure,
    String? errorMessage,
    bool? isLoading,
    String? status,
  }) {
    return AddPostState(
      title: title ?? this.title,
      description: description ?? this.description,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        failure,
        errorMessage,
        isLoading,
        status,
      ];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'failure': failure,
      'errorMessage': errorMessage,
      'isLoading': isLoading,
      'status': status
    };
  }
}
