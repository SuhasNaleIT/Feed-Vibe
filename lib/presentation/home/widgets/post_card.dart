import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:feedvibe/data/post/models/comment_model.dart';
import 'package:feedvibe/domain/post/entities/post_entity.dart';
import 'package:feedvibe/presentation/core/sized_boxes/sized_boxes.dart';
import 'package:feedvibe/presentation/home/cubits/add_comment/add_comment_cubit.dart';
import 'package:feedvibe/presentation/home/widgets/comments_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostCard extends StatefulWidget {
  const PostCard({required this.post, super.key});

  final PostEntity post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> likePost(String postId, String uid) async {
    try {
      DocumentReference postRef =
          FirebaseFirestore.instance.collection('posts').doc(postId);
      DocumentSnapshot doc = await postRef.get();
      if (doc.exists) {
        List likes = (doc.data() as Map)['likes'] ?? [];
        if (likes.contains(uid)) {
          await postRef.update({
            'likes': FieldValue.arrayRemove([uid])
          });
        } else {
          await postRef.update({
            'likes': FieldValue.arrayUnion([uid])
          });
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final likes = widget.post.likes;
    final isLiked = likes!.contains(uid);

    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.title ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBoxHeight8,
            Text(widget.post.description ?? ''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Posted by: ${widget.post.username}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                // BlocBuilder<LikesCubit, LikesState>(
                //   builder: (context, state) {
                //     final likes =
                //         state is LikesUpdated ? state.likes : widget.post.likes;
                //     final isLiked = likes!.contains(uid);
                //     return Column(
                //       children: [
                //         IconButton(
                //           padding: EdgeInsets.zero,
                //           visualDensity: VisualDensity.compact,
                //           icon: Icon(
                //             isLiked ? Icons.favorite : Icons.favorite_border,
                //             color: isLiked ? Colors.red : Colors.grey,
                //           ),
                //           onPressed: () {
                //             context
                //                 .read<LikesCubit>()
                //                 .likePost(widget.post.postId!, uid, likes);
                //           },
                //         ),
                //         Text('${likes.length} likes'),
                //       ],
                //     );
                //   },
                // ),
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(widget.post.postId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.data!.exists) {
                      return const Text('No data');
                    }
                    final postData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    final likes = List<String>.from(postData['likes'] ?? []);
                    final isLiked = likes.contains(uid);
                    return Column(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey,
                          ),
                          onPressed: () => likePost(widget.post.postId!, uid),
                        ),
                        Text('${likes.length} likes'),
                      ],
                    );
                  },
                ),
              ],
            ),
            SizedBoxHeight8,
            CommentsSection(postId: widget.post.postId!),
          ],
        ),
      ),
    );
  }
}

class CommentsSection extends StatefulWidget {
  final String postId;

  const CommentsSection({required this.postId, super.key});

  @override
  _CommentsSectionState createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  //* Format the date
  String formatTimestamp(DateTime timestamp) {
    Duration difference = DateTime.now().difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inMinutes}m';
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.whiteColor,
      textColor: AppColors.blackColor,
      fontSize: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: commentController,
          onChanged: (value) {
            context.read<AddCommentCubit>().updateComment(comment: value);
          },
          decoration: InputDecoration(
            labelText: 'Add a comment...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                context
                    .read<AddCommentCubit>()
                    .addComment(postId: widget.postId)
                    .then((_) {
                  commentController.clear();
                  showToast('Comment posted successfully!');
                }).catchError((error) {
                  showToast('Failed to post comment');
                });
              },
            ),
          ),
        ),
        SizedBoxHeight15,
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.postId)
              .collection('comments')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final comments = snapshot.data!.docs.map((doc) {
              return CommentModel.fromJson(doc.data() as Map<String, dynamic>);
            }).toList();

            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: comments.length > 2 ? 2 : comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Card(
                      color: AppColors.lightestGreyColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${comment.username} :',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Text('at ${comment.timestamp}'),
                                Text(
                                  formatTimestamp(comment.timestamp!),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.darkGreyColor),
                                ),
                              ],
                            ),
                            SizedBoxHeight8,
                            Text('${comment.comment}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (comments.length > 2)
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CommentsPage(postId: widget.postId),
                        ),
                      );
                    },
                    child: Text('View All Comments (${comments.length})'),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
