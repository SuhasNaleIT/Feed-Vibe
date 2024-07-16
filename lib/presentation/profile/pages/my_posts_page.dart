import 'package:feedvibe/core/injectable_modules/injection_container.dart';
import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:feedvibe/presentation/bottom_navigation_bar/cubits/index_holder_cubit.dart';
import 'package:feedvibe/presentation/core/sized_boxes/sized_boxes.dart';
import 'package:feedvibe/presentation/profile/cubits/my_posts/my_posts_cubit.dart';
import 'package:feedvibe/presentation/home/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyPostsPage extends StatefulWidget {
  const MyPostsPage({super.key, required this.myPostsCubit});

  final MyPostsCubit myPostsCubit;

  static Widget create() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyPostsCubit>(
          create: (context) => di<MyPostsCubit>(),
        ),
      ],
      child: Consumer<MyPostsCubit>(
        builder: (_, MyPostsCubit myPostsCubit, __) {
          return MyPostsPage(
            myPostsCubit: myPostsCubit,
          );
        },
      ),
    );
  }

  @override
  State<MyPostsPage> createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage> {
  late Future<List<Map<String, dynamic>>> _userPostsFuture;

  @override
  void initState() {
    super.initState();
    context.read<MyPostsCubit>().fetchMyPosts();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: RefreshIndicator(
        onRefresh: () => context.read<MyPostsCubit>().fetchMyPosts(),
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
              'My Posts',
              style: TextStyle(color: AppColors.whiteColor),
            ),
            centerTitle: true,
            backgroundColor: AppColors.primaryBGColor,
          ),
          body: BlocBuilder<MyPostsCubit, MyPostsState>(
            builder: (context, state) {
              if (state is MyPostsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MyPostsError) {
                return Center(
                    child: Text('Error loading posts: ${state.error}'));
              } else if (state is MyPostsLoaded) {
                final posts = state.myPosts;
                if (posts.isEmpty) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
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
