import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CommentEntity extends Equatable {
  const CommentEntity({
    required this.commentId,
    required this.postId,
    required this.uid,
    required this.username,
    required this.comment,
    required this.timestamp,
  });

  final String? commentId;
  final String? postId;
  final String? uid;
  final String? username;
  final String? comment;
  final DateTime? timestamp;

  @override
  List<Object?> get props => <Object?>[
        commentId,
        postId,
        uid,
        username,
        comment,
        timestamp,
      ];

  @override
  String toString() {
    return 'CommentEntity { '
        'commentId: $commentId,'
        'postId: $postId,'
        'uid: $uid,'
        'username: $username,'
        'comment: $comment,'
        'timestamp: $timestamp,'
        ' }';
  }
}
