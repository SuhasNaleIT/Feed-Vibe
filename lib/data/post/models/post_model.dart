import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedvibe/domain/post/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    super.postId,
    super.title,
    super.description,
    super.username,
    super.uid,
    super.likes,
    super.comments,
    super.timestamp,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      username: json['username'] as String?,
      uid: json['uid'] as String?,
      likes: json['likes'] == null
          ? []
          : (json['likes'] as List).map((e) => e as String).toList(),
      comments: json['comments'] == null
          ? []
          : (json['comments'] as List).map((e) => e as String).toList(),
      timestamp: json['timestamp'] != null
          ? (json['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'title': title,
      'description': description,
      'username': username,
      'uid': uid,
      'likes': likes,
      'comments': comments,
      'timestamp': timestamp,
    };
  }


  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'uid': uid,
      'postId': postId,
      'username': username,
      'likes': likes,
      'comments': comments,
      'timestamp': Timestamp.fromDate(timestamp!),
    };
  }
}
