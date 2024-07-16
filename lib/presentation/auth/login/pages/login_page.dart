import 'dart:developer';
import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:feedvibe/core/widgets/custom_snackbar.dart';
import 'package:feedvibe/presentation/auth/cubits/get_user_data_from_cache/get_user_data_from_cache_cubit.dart';
import 'package:feedvibe/presentation/auth/cubits/login/login_cubit.dart';
import 'package:feedvibe/presentation/auth/signup/pages/signup_page.dart';
import 'package:feedvibe/presentation/bottom_navigation_bar/cubits/index_holder_cubit.dart';
import 'package:feedvibe/presentation/bottom_navigation_bar/pages/bottom_navigation_page.dart';
import 'package:feedvibe/presentation/core/sized_boxes/sized_boxes.dart';
import 'package:feedvibe/presentation/core/widgets/platform_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    // emailController.text = 'suhas@gmail.com';
    // passwordController.text = 'test@123';
    super.initState();
    context.read<LoginCubit>().clearState();
    context.read<PageIndexHolderCubit>().updatePageIndex(0);

    context.read<GetUserDataFromCacheCubit>().getUserFromCache();
  }

  @override
  void dispose() {
    emailController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<GetUserDataFromCacheCubit, GetUserDataFromCacheState>(
        builder: (context, state) {
          if (state is GetUserDataFromCacheInitial ||
              state is GetUserDataFromCacheLoading) {
            return const Scaffold(
              body: Center(
                child: PlatformCircularProgressIndicator(),
              ),
            );
          } else if (state is GetUserDataFromCacheLoaded) {
            return state.appUser != null
                ? const BottomNavigationPage()
                : buildLoginForm(context, size);
          } else if (state is GetUserDataFromCacheError) {
            return buildLoginForm(context, size);
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Unknown state'),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildLoginForm(BuildContext context, Size size) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            height: size.height - kToolbarHeight,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocListener<LoginCubit, LoginState>(
                  listenWhen: (previous, current) => previous != current,
                  listener: (context, state) {
                    debugPrint('state: $state');
                    if (state.appUserEntity != null) {
                      debugPrint('User Logged In');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const BottomNavigationPage(),
                        ),
                      );
                    }
                    if (state.failure != null) {
                      log(state.failure.toString());
                      if (state.failure is FirebaseAuthLogInFailedFailure) {
                        showCustomSnackbar(context, 'Login Failed');
                      } else if (state.failure
                          is FirebaseAuthLogInUserDisabledFailure) {
                        showCustomSnackbar(context, 'User Disabled');
                      } else if (state.failure
                          is FirebaseAuthLogInUserNotFoundFailure) {
                        showCustomSnackbar(context, 'User Not Found');
                      } else if (state.failure
                          is FirebaseAuthLogInWrongPasswordFailure) {
                        showCustomSnackbar(context, 'Incorrect Password');
                      } else if (state.failure
                          is FirebaseAuthLogInUnknownFailure) {
                        showCustomSnackbar(context, 'Unknown Failure');
                      } else if (state.failure
                          is FirebaseAuthLogInTooManyRequestsFailure) {
                        showCustomSnackbar(context, 'Too Many Requests');
                      } else if (state.failure
                          is FirebaseAuthLogInInvalidCredentialsFailure) {
                        showCustomSnackbar(context, 'Invalid Credentials');
                      } else if (state.failure
                          is FirebaseAuthForgetPasswordUserNotFoundFailure) {
                        showCustomSnackbar(context, 'User Not Found');
                      } else if (state.failure
                          is FirebaseAuthForgetPasswordUnknownFailure) {
                        showCustomSnackbar(context, 'Unknown Failure');
                      } else if (state.failure
                          is FirebaseAuthForgetPasswordNoInternetFailure) {
                        showCustomSnackbar(context, 'No Internet');
                      } else if (state.failure
                          is FirebaseAuthNetworkRequestFailedFailure) {
                        showCustomSnackbar(context, 'Bad Request');
                      } else {
                        showCustomSnackbar(context, 'Something went wrong');
                      }
                      context.read<LoginCubit>().clearState();
                      // context.read<LoginCubit>().updateFailure(failure: null);
                      emailController.clear();
                      passwordController.clear();
                    }
                  },
                  child: const SizedBox(),
                ),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                const Text(
                  'ƒεε∂ ѵเɓε',
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                  ),
                ),
                SizedBoxHeight50,
                const Row(
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBoxWidth2,
                    Text(
                      '*',
                      style: TextStyle(color: AppColors.redButtonColor),
                    ),
                  ],
                ),
                SizedBoxHeight5,
                TextField(
                  controller: emailController,
                  onChanged: (value) {
                    if (value.isNotEmpty &&
                        RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          caseSensitive: false,
                        ).hasMatch(value)) {
                      context.read<LoginCubit>().updateEmail(email: value);
                      context
                          .read<LoginCubit>()
                          .updateEmailErrorMessage(emailErrorMessage: '');
                    } else {
                      context.read<LoginCubit>().updateEmailErrorMessage(
                            emailErrorMessage: 'Enter a valid Email',
                          );
                    }
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: normalInputBorder(),
                    focusedBorder: focusedInputBorder(),
                    enabledBorder: normalInputBorder(),
                    filled: true,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                if (context
                        .watch<LoginCubit>()
                        .state
                        .emailErrorMessage
                        ?.isNotEmpty ??
                    false)
                  Text(
                    context.watch<LoginCubit>().state.emailErrorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  )
                else
                  const SizedBox(),
                SizedBoxHeight15,
                const Row(
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBoxWidth2,
                    Text(
                      '*',
                      style: TextStyle(color: AppColors.redButtonColor),
                    ),
                  ],
                ),
                SizedBoxHeight5,
                TextField(
                  controller: passwordController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      context
                          .read<LoginCubit>()
                          .updatePassword(password: value);
                      context
                          .read<LoginCubit>()
                          .updatePasswordErrorMessage(passwordErrorMessage: '');
                    } else {
                      context.read<LoginCubit>().updatePasswordErrorMessage(
                            passwordErrorMessage: "Password can't be empty",
                          );
                    }
                  },
                  enableSuggestions: false,
                  autocorrect: false,
                  textInputAction: TextInputAction.done,
                  obscureText: context.watch<LoginCubit>().state.showPassword,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        context.watch<LoginCubit>().state.showPassword == true
                            ? Icons.lock_outline
                            : Icons.lock_open_outlined,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        context.read<LoginCubit>().updateShowPassword(
                              showPassword: !(context
                                      .read<LoginCubit>()
                                      .state
                                      .showPassword ??
                                  false),
                            );
                      },
                    ),
                    border: normalInputBorder(),
                    focusedBorder: focusedInputBorder(),
                    enabledBorder: normalInputBorder(),
                    filled: true,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  keyboardType: TextInputType.text,
                ),
                if (context
                        .watch<LoginCubit>()
                        .state
                        .passwordErrorMessage
                        ?.isNotEmpty ??
                    false)
                  Text(
                    context.watch<LoginCubit>().state.passwordErrorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  )
                else
                  const SizedBox(),
                SizedBoxHeight24,
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: (state.email?.isNotEmpty ?? false) &&
                              (state.password?.isNotEmpty ?? false) &&
                              !state.isLoading
                          ? () {
                              context
                                  .read<LoginCubit>()
                                  .loginWithEmailAndPassowrd();
                            }
                          : null,
                      child: Container(
                        width: 200,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: ShapeDecoration(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          color: (state.email?.isNotEmpty ?? false) &&
                                  (state.password?.isNotEmpty ?? false)
                              ? AppColors.blackColor
                              : AppColors.darkGreyColor,
                        ),
                        child: state.isLoading == true
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: PlatformCircularProgressIndicator(),
                              )
                            : const Text(
                                'Log in',
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                      ),
                    );
                  },
                ),
                SizedBoxHeight12,
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        'Dont have an account?',
                        style: TextStyle(
                          color: AppColors.greyColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          ' Signup.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder normalInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.lightGreyColor,
        width: 0.2,
      ),
    );
  }

  OutlineInputBorder focusedInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.greyColor,
        width: 0.2,
      ),
    );
  }
}
