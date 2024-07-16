import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:feedvibe/presentation/bottom_navigation_bar/cubits/index_holder_cubit.dart';
import 'package:feedvibe/presentation/home/pages/home_page.dart';
import 'package:feedvibe/presentation/post/pages/add_post_page.dart';
import 'package:feedvibe/presentation/profile/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final tabs = [
    const HomePage(),
    const AddPostPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final int currentIndex = context.watch<PageIndexHolderCubit>().state;

    return Scaffold(
      backgroundColor: Colors.white,
      body: tabs[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(246, 247, 248, 1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.primaryBGColor,
            // backgroundColor: const Color.fromRGBO(246, 247, 248, 1),
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedItemColor: const Color.fromRGBO(229, 126, 33, 1),
            unselectedItemColor: const Color.fromRGBO(132, 130, 130, 1),
            elevation:
                10, 
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                  color: (currentIndex == 0)
                      ? AppColors.primaryColor
                      : AppColors.lightGrey,
                ),
                label: '',
                backgroundColor: AppColors.primaryColor,
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle,
                    size: 30,
                    color: (currentIndex == 1)
                        ? AppColors.primaryColor
                        : AppColors.lightGrey,
                  ),
                  label: '',
                  backgroundColor: AppColors.primaryColor),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 30,
                    color: (currentIndex == 2)
                        ? AppColors.primaryColor
                        : AppColors.lightGrey,
                  ),
                  label: '',
                  backgroundColor: AppColors.primaryColor),
            ],
            onTap: (int index) {
              context.read<PageIndexHolderCubit>().updatePageIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
