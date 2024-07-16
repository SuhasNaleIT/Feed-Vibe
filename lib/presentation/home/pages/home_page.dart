// posts_page.dart
import 'dart:developer';
import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:feedvibe/presentation/auth/cubits/get_user_data_from_cache/get_user_data_from_cache_cubit.dart';
import 'package:feedvibe/presentation/core/sized_boxes/sized_boxes.dart';
import 'package:feedvibe/presentation/bottom_navigation_bar/cubits/index_holder_cubit.dart';
import 'package:feedvibe/presentation/home/cubits/posts/posts_cubit.dart';
import 'package:feedvibe/presentation/home/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<GetUserDataFromCacheCubit>().getUserFromCache();
    context.read<PostsCubit>().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: RefreshIndicator(
        onRefresh: () => context.read<PostsCubit>().fetchPosts(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Feeds',
              style: TextStyle(
                color: AppColors.whiteColor,
              ),
            ),
            backgroundColor: AppColors.primaryBGColor,
          ),
          body: BlocBuilder<PostsCubit, PostsState>(
            builder: (context, state) {
              if (state is PostsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PostsError) {
                return Center(
                    child: Text(
                        'Error loading posts: ${state.failure.failureMessage}'));
              } else if (state is PostsLoaded) {
                final posts = state.posts;
                if (posts.isEmpty) {
                  return GestureDetector(
                    onTap: () {
                      context.read<PageIndexHolderCubit>().updatePageIndex(1);
                    },
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.hourglass_empty_outlined),
                                  SizedBoxWidth14,
                                  Text(
                                    'No Posts...!!!   Create one',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_rounded,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                  );
                }
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    final likes = posts[index].likes ?? [];
                    // context.read<LikesCubit>().updateLikes(likes);
                    log('Posts in UI: ${posts[index]}');
                    return PostCard(post: post);
                  },
                );
              }
              return const Center(child: Text('Something went wrong'));
            },
          ),
        ),
      ),
    );
  }
}
