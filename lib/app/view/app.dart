import 'package:feedvibe/core/injectable_modules/injection_container.dart';
import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:feedvibe/presentation/auth/cubits/get_user_data_from_cache/get_user_data_from_cache_cubit.dart';
import 'package:feedvibe/presentation/auth/cubits/login/login_cubit.dart';
import 'package:feedvibe/presentation/auth/cubits/signup/signup_cubit.dart';
import 'package:feedvibe/presentation/auth/login/pages/login_page.dart';
import 'package:feedvibe/presentation/bottom_navigation_bar/cubits/index_holder_cubit.dart';
import 'package:feedvibe/presentation/home/cubits/posts/posts_cubit.dart';
import 'package:feedvibe/presentation/post/cubits/add_post/add_post_cubit.dart';
import 'package:feedvibe/presentation/home/cubits/add_comment/add_comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) => di<SignupCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              di<GetUserDataFromCacheCubit>()..getUserFromCache(),
        ),
        BlocProvider(
          create: (context) => di<PostsCubit>(),
        ),
        BlocProvider(
          create: (context) => di<AddPostCubit>(),
        ),
        BlocProvider(
          create: (context) => di<AddCommentCubit>(),
        ),
        BlocProvider(
          create: (context) => di<PageIndexHolderCubit>(),
        ),
        // BlocProvider(
        //   create: (context) => di<LikesCubit>(),
        // ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            colorScheme: const ColorScheme.light(
              primary: AppColors.blackColor,
              onPrimaryFixedVariant: AppColors.blackColor,
            ),
            useMaterial3: true,
          ),
          // localizationsDelegates: AppLocalizations.localizationsDelegates,
          // supportedLocales: AppLocalizations.supportedLocales,
          home: const LoginPage(),
        ),
      ),
    );
  }
}
