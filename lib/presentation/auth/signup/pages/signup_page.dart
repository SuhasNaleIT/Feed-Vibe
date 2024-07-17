import 'dart:developer';

import 'package:feedvibe/core/error/failures.dart';
import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:feedvibe/core/widgets/custom_snackbar.dart';
import 'package:feedvibe/presentation/auth/cubits/signup/signup_cubit.dart';
import 'package:feedvibe/presentation/auth/cubits/signup/signup_state.dart';
import 'package:feedvibe/presentation/auth/login/pages/login_page.dart';
import 'package:feedvibe/presentation/core/sized_boxes/sized_boxes.dart';
import 'package:feedvibe/presentation/core/widgets/platform_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  // final SignupCubit signupCubit;

  // static Widget create() {
  //   return MultiBlocProvider(
  //     providers: [
  //       BlocProvider<SignupCubit>(
  //         create: (context) => di<SignupCubit>(),
  //       ),
  //     ],
  //     child: Consumer<SignupCubit>(
  //       builder: (_, SignupCubit signupCubit, __) {
  //         return SignupPage(
  //           signupCubit: signupCubit,
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bioController = TextEditingController();
  DateTime? selectedDate;
  final focusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    bioController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              // decoration: const BoxDecoration(color: AppColors.blackColor),
              padding: const EdgeInsets.symmetric(horizontal: 32),
              height: size.height - kToolbarHeight,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocListener<SignupCubit, SignupState>(
                    listener: (context, state) {
                      debugPrint('state: $state');
                      if (state.status != null) {
                        debugPrint('User Created');
                        showCustomSnackbar(context, 'Signup Successful');
                        context.read<SignupCubit>().clearState();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                        // ).then((value) {
                        //   context.read<SignupCubit>().clearState();
                        // });
                      }
                      if (state.failure != null) {
                        log(state.failure.toString());
                        context.read<SignupCubit>().clearState();
                        emailController.clear();
                        userNameController.clear();
                        passwordController.clear();
                        confirmPasswordController.clear();
                        bioController.clear();
                        if (state.failure
                            is FirebaseAuthSignUpInvalidEmailFailure) {
                          showCustomSnackbar(context, 'Invalid Email');
                        } else if (state.failure
                            is FirebaseAuthSignUpUserDisabledFailure) {
                          showCustomSnackbar(context, 'User Disabled');
                        } else if (state.failure
                            is FirebaseAuthSignUpEmailAlreadyInUseFailure) {
                          showCustomSnackbar(context, 'Email alreaday in use');
                        } else if (state.failure
                            is FirebaseAuthSignUpOperationNotAllowedFailure) {
                          showCustomSnackbar(context, 'Signup not allowed');
                        } else if (state.failure
                            is FirebaseAuthSignUpWeakPasswordFailure) {
                          showCustomSnackbar(context, '');
                        } else if (state.failure
                            is FirebaseAuthSignUpNetworkRequestFailedFailure) {
                          showCustomSnackbar(context, 'Network Failure');
                        } else if (state.failure
                            is FirebaseAuthSignUpUnknownSignUpFailure) {
                          showCustomSnackbar(context, 'Unknown Failure');
                        } else {
                          showCustomSnackbar(context, 'Something went wrong');
                        }
                      }
                    },
                    child: const SizedBox(),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  const Center(
                    child: Text(
                      'ƒεε∂ ѵเɓε',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 60,
                      ),
                    ),
                  ),
                  SizedBoxHeight40,
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
                        context
                            .read<SignupCubit>()
                            .updateEmail(emailValue: value);

                        context.read<SignupCubit>().updateEmailErrorMessage(
                              emailErrorMessage: '',
                            );
                      } else {
                        context.read<SignupCubit>().updateEmailErrorMessage(
                              emailErrorMessage: 'Enter a valid Email',
                            );
                      }
                    },
                    enableSuggestions: false,
                    autocorrect: false,
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
                          .watch<SignupCubit>()
                          .state
                          .emailErrorMessage
                          ?.isNotEmpty ??
                      false)
                    Text(
                      context.watch<SignupCubit>().state.emailErrorMessage!,
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
                        'Username',
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
                    controller: userNameController,
                    onChanged: (value) {
                      if (value.length < 2 || value.length > 12) {
                        context.read<SignupCubit>().updateUsernameErrorMessage(
                              usernameErrorMessage:
                                  'Username length should be 2-12 Characters',
                            );
                      } else {
                        context
                            .read<SignupCubit>()
                            .updateUserName(userName: value);
                        context.read<SignupCubit>().updateUsernameErrorMessage(
                            usernameErrorMessage: '');
                      }
                    },
                    enableSuggestions: false,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: normalInputBorder(),
                      focusedBorder: focusedInputBorder(),
                      enabledBorder: normalInputBorder(),
                      filled: true,
                      contentPadding: const EdgeInsets.all(8),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  if (context
                          .watch<SignupCubit>()
                          .state
                          .usernameErrorMessage
                          ?.isNotEmpty ??
                      false)
                    Text(
                      context.watch<SignupCubit>().state.usernameErrorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    )
                  else
                    const SizedBox(),
                  SizedBoxHeight15,
                  const Text(
                    'Bio',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBoxHeight5,
                  TextField(
                    controller: bioController,
                    onChanged: (value) {
                      context.read<SignupCubit>().updateBio(bio: value);
                    },
                    enableSuggestions: false,
                    autocorrect: false,
                    // textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Bio',
                      border: normalInputBorder(),
                      focusedBorder: focusedInputBorder(),
                      enabledBorder: normalInputBorder(),
                      filled: true,
                      contentPadding: const EdgeInsets.all(8),
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 2,
                  ),
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
                            .read<SignupCubit>()
                            .updatePassword(password: value);
                        context.read<SignupCubit>().updatePasswordErrorMessage(
                            passwordErrorMessage: '');
                      } else {
                        context.read<SignupCubit>().updatePasswordErrorMessage(
                              passwordErrorMessage: "Password can't be empty",
                            );
                      }
                    },
                    enableSuggestions: false,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    obscureText:
                        context.watch<SignupCubit>().state.showPassword,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          context.watch<SignupCubit>().state.showPassword ==
                                  true
                              ? Icons.lock_outline
                              : Icons.lock_open_outlined,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          context.read<SignupCubit>().updateShowPassword(
                                showPassword: !(context
                                        .read<SignupCubit>()
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
                          .watch<SignupCubit>()
                          .state
                          .passwordErrorMessage
                          ?.isNotEmpty ??
                      false)
                    Text(
                      context.watch<SignupCubit>().state.passwordErrorMessage!,
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
                        'Confirm Password',
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
                    controller: confirmPasswordController,
                    onChanged: (value) {
                      if (Provider.of<SignupCubit>(
                            context,
                            listen: false,
                          ).state.password ==
                          value) {
                        context.read<SignupCubit>().updateConfirmPassword(
                              confirmPassword: value,
                            );
                        context
                            .read<SignupCubit>()
                            .updateConfirmPasswordErrorMessage(
                              confirmPasswordMessage: '',
                            );
                      } else {
                        context
                            .read<SignupCubit>()
                            .updateConfirmPasswordErrorMessage(
                              confirmPasswordMessage: 'Password Mismatch',
                            );
                      }
                    },
                    enableSuggestions: false,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    obscureText: context
                            .watch<SignupCubit>()
                            .state
                            .showConfirmPassword ??
                        false,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          context
                                      .watch<SignupCubit>()
                                      .state
                                      .showConfirmPassword ==
                                  true
                              ? Icons.lock_outline
                              : Icons.lock_open_outlined,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          context.read<SignupCubit>().updateShowConfirmPassword(
                                showConfirmPassword: !(context
                                        .read<SignupCubit>()
                                        .state
                                        .showConfirmPassword ??
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
                          .watch<SignupCubit>()
                          .state
                          .confirmPasswordMessage
                          ?.isNotEmpty ??
                      false)
                    Text(
                      context
                          .watch<SignupCubit>()
                          .state
                          .confirmPasswordMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    )
                  else
                    const SizedBox(),
                  SizedBoxHeight15,
                  BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: (state.emailAddress?.isNotEmpty ?? false) &&
                                (state.userName?.isNotEmpty ?? false) &&
                                (state.password?.isNotEmpty ?? false) &&
                                (state.confirmPassword?.isNotEmpty ?? false) &&
                                !state.isLoading
                            ? () {
                                context
                                    .read<SignupCubit>()
                                    .signupWithEmailAndPassword();
                              }
                            : null,
                        child: Center(
                          child: Container(
                            width: 200,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: ShapeDecoration(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              color: (state.emailAddress?.isNotEmpty ??
                                          false) &&
                                      (state.userName?.isNotEmpty ?? false) &&
                                      (state.password?.isNotEmpty ?? false) &&
                                      (state.confirmPassword?.isNotEmpty ??
                                          false)
                                  ? AppColors.blackColor
                                  : AppColors.darkGreyColor,
                            ),
                            child: state.isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: PlatformCircularProgressIndicator(),
                                  )
                                : const Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                    ),
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
                          'Already have an account?',
                          style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text(
                            ' Login.',
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
