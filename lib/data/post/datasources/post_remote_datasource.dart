import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedvibe/core/logger/applogger.dart';
import 'package:feedvibe/data/post/models/comment_model.dart';
import 'package:feedvibe/data/post/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:injectable/injectable.dart';

@Singleton()
class PostRemoteDataSource {
  PostRemoteDataSource(
    this.appLogger, {
    // required this.api,
    // required this.client,
    required this.firebaseAuth,
  });

  // final API api;
  // final http.Client client;
  final firebase_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AppLogger appLogger;

  Future<String?> createPost({
    required PostModel postModel,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postModel.postId)
          .set(postModel.toFirestore());

      return 'Post uploaded successfully';
    } catch (e) {
      print('Error creating post: $e');
      return e.toString();
    }
  }

  Future<List<PostModel>?> getPost() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('posts')
          .orderBy('timestamp', descending: true)
          .get();

      List<PostModel> posts = querySnapshot.docs
          .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      appLogger.d(
          PostRemoteDataSource, 'Posts in Get Post Cubit: ${posts.first}');
      return posts;
    } catch (e) {
      print('Error creating post: $e');
      e.toString();
    }
    return null;
  }

  Future<String?> createComment({
    required CommentModel commentModel,
  }) async {
    try {
      await _firestore
          .collection('posts')
          .doc(commentModel.postId)
          .collection('comments')
          .add(commentModel.toFirestore());

      return 'Comment added successfully';
    } catch (e) {
      print('Error creating post: $e');
      return e.toString();
    }
  }
}
