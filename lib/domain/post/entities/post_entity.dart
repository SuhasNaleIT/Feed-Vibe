import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class PostEntity extends Equatable {
  const PostEntity({
    required this.postId,
    required this.title,
    required this.description,
    required this.username,
    required this.uid,
    required this.likes,
    required this.comments,
    required this.timestamp,
  });

  final String? postId;
  final String? title;
  final String? description;
  final String? username;
  final String? uid;
  final List<String>? likes;
  final List<String>? comments;
  final DateTime? timestamp;

  @override
  List<Object?> get props => <Object?>[
        postId,
        title,
        description,
        username,
        uid,
        likes,
        comments,
        timestamp,
      ];

  @override
  String toString() {
    return 'PostEntity { '
        'postId: $postId, '
        'title: $title,'
        'description: $description,'
        'username: $username,'
        'uid: $uid,'
        'likes: $likes,'
        'comments: $comments,'
        'timestamp: $timestamp,'
        ' }';
  }
}
