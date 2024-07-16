import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedvibe/domain/post/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    super.commentId,
    super.postId,
    super.uid,
    super.username,
    super.comment,
    super.timestamp,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'] as String?,
      postId: json['postId'] as String?,
      uid: json['uid'] as String?,
      username: json['username'] as String?,
      comment: json['comment'] as String?,
      timestamp: json['timestamp'] != null
          ? (json['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'postId': postId,
      'uid': uid,
      'username': username,
      'comment': comment,
      'timestamp': timestamp,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'commentId': commentId,
      'postId': postId,
      'uid': uid,
      'username': username,
      'comment': comment,
      'timestamp': Timestamp.fromDate(timestamp!),
    };
  }
}
