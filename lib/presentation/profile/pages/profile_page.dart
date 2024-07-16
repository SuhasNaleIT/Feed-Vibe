import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:feedvibe/core/widgets/platform_alert_dialog.dart';
import 'package:feedvibe/presentation/auth/cubits/get_user_data_from_cache/get_user_data_from_cache_cubit.dart';
import 'package:feedvibe/presentation/auth/login/pages/login_page.dart';
import 'package:feedvibe/presentation/core/sized_boxes/sized_boxes.dart';
import 'package:feedvibe/presentation/core/widgets/platform_circular_indicator.dart';
import 'package:feedvibe/presentation/profile/pages/my_posts_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<GetUserDataFromCacheCubit>().getUserFromCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;
    final FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.whiteColor,
          ),
        ),
        backgroundColor: AppColors.primaryBGColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 15),
        child: Column(
          children: [
            BlocBuilder<GetUserDataFromCacheCubit, GetUserDataFromCacheState>(
              builder: (context, state) {
                if (state is GetUserDataFromCacheInitial) {
                  return const PlatformCircularProgressIndicator();
                } else if (state is GetUserDataFromCacheLoading) {
                  return const PlatformCircularProgressIndicator();
                } else if (state is GetUserDataFromCacheError) {
                  return const Center(
                    child: Text('Cache Error'),
                  );
                } else if (state is GetUserDataFromCacheLoaded) {
                  return SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: AppColors.lightestGreyColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, ${state.appUser?.username ?? 'Anonymous'}  👋',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBoxHeight8,
                            Text(
                              'Email: ${state.appUser?.email}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              'Bio: ${state.appUser?.bio ?? ''}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else
                  return const SizedBox();
              },
            ),
            SizedBoxHeight15,
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyPostsPage.create(),
                ));
              },
              child: profileOptions(
                title: 'My Posts',
                icon: Icons.read_more_outlined,
                context: context,
              ),
            ),
            // const Spacer(),
            GestureDetector(
              onTap: () async {
                final value = await showPlatformAlertDialog(
                  context,
                  title: 'Log out?',
                  content: 'Are you sure you want to log out?',
                  cancelActionText: 'Cancel',
                  defaultActionText: 'Log out',
                  isDestructiveActionIOS: true,
                );
                if (value != null && value) {
                  if (!context.mounted) return;
                  await context.read<GetUserDataFromCacheCubit>().clearCache();
                  await auth.signOut();

                  if (!context.mounted) return;
                  await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false);
                }
                if (!context.mounted) return;
              },
              child: profileOptions(
                title: 'Logout',
                icon: Icons.logout_outlined,
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding profileOptions(
      {required String title,
      required IconData icon,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
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
                  Icon(icon),
                  SizedBoxWidth14,
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
    );
  }
}
