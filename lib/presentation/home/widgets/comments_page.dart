import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:feedvibe/data/post/models/comment_model.dart';
import 'package:feedvibe/presentation/core/sized_boxes/sized_boxes.dart';
import 'package:feedvibe/presentation/home/cubits/add_comment/add_comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({required this.postId, super.key});

  final String postId;

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: AppColors.whiteColor,
            ),
          ),
          title: const Text(
            'All Comments',
            style: TextStyle(color: AppColors.whiteColor),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryBGColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
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
                      return CommentModel.fromJson(
                          doc.data() as Map<String, dynamic>);
                    }).toList();
                    return ListView.builder(
                      itemCount: comments.length,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: commentController,
                  onChanged: (value) {
                    context
                        .read<AddCommentCubit>()
                        .updateComment(comment: value);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
