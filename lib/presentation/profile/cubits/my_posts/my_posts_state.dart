// posts_state.dart
part of 'my_posts_cubit.dart';

abstract class MyPostsState extends Equatable {
  const MyPostsState();

  @override
  List<Object> get props => [];
}

class MyPostsInitial extends MyPostsState {}

class MyPostsLoading extends MyPostsState {}

class MyPostsLoaded extends MyPostsState {
  const MyPostsLoaded(this.myPosts);

  final List<PostEntity> myPosts;

  @override
  List<Object> get props => [myPosts];
}

class MyPostsError extends MyPostsState {
  final String error;

  const MyPostsError(this.error);

  @override
  List<Object> get props => [error];
}
