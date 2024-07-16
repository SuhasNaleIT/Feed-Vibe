// // cubit/likes_cubit.dart
// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:feedvibe/presentation/home/cubits/likes/likes_state.dart';
// import 'package:injectable/injectable.dart';

// @injectable
// class LikesCubit extends Cubit<LikesState> {
//   final FirebaseFirestore _firestore;

//   LikesCubit(this._firestore) : super(LikesInitial());

//   void likePost(String postId, String uid, List<String> currentLikes) async {
//     try {
//       if (currentLikes.contains(uid)) {
//         // Remove like locally
//         List<String> updatedLikes =
//             currentLikes.where((like) => like != uid).toList();
//         emit(LikesUpdated(updatedLikes));

//         // Update Firestore
//         await _firestore.collection('posts').doc(postId).update({
//           'likes': FieldValue.arrayRemove([uid])
//         });
//       } else {
//         // Add like locally
//         List<String> updatedLikes = [...currentLikes, uid];
//         emit(LikesUpdated(updatedLikes));

//         // Update Firestore
//         await _firestore.collection('posts').doc(postId).update({
//           'likes': FieldValue.arrayUnion([uid])
//         });
//       }
//     } catch (e) {
//       emit(LikesError(e.toString()));
//     }
//   }

//   void updateLikes(List<String> likes) {
//     emit(LikesUpdated(likes));
//   }
// }
