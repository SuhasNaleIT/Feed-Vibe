// posts_cubit.dart
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:feedvibe/data/post/models/post_model.dart';
import 'package:feedvibe/domain/auth/usecases/get_cached_user_usecase.dart';
import 'package:feedvibe/domain/post/entities/post_entity.dart';
import 'package:injectable/injectable.dart';

part 'my_posts_state.dart';

@injectable
class MyPostsCubit extends Cubit<MyPostsState> {
  MyPostsCubit(this._firestore, this.getCachedUserUsecase)
      : super(MyPostsInitial());

  final FirebaseFirestore _firestore;
  final GetCachedUserUsecase getCachedUserUsecase;

  Future<List<Map<String, dynamic>>> fetchMyPosts() async {
    List<Map<String, dynamic>> posts = [];
    try {
      emit(MyPostsLoading());
      final user = await getCachedUserUsecase.call();

      QuerySnapshot querySnapshot = await _firestore
          .collection('posts')
          .where('uid', isEqualTo: user.fold((l) => null, (r) => r.id))
          .get();

      List<PostEntity> posts = querySnapshot.docs
          .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      log("Posts: $posts");
      emit(MyPostsLoaded(posts));
    } catch (e) {
      emit(MyPostsError(e.toString()));
    }
    return posts;
  }
}
