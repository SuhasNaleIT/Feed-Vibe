// posts_state.dart
part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  const PostsLoaded({required this.posts});

  final List<PostEntity> posts;

  @override
  List<Object> get props => [posts];
}

class PostsError extends PostsState {
  const PostsError({required this.failure});

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
