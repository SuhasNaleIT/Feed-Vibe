import 'package:feedvibe/core/theme/app_colors.dart';
import 'package:feedvibe/core/widgets/custom_snackbar.dart';
import 'package:feedvibe/presentation/core/sized_boxes/sized_boxes.dart';
import 'package:feedvibe/presentation/core/widgets/platform_circular_indicator.dart';
import 'package:feedvibe/presentation/post/cubits/add_post/add_post_cubit.dart';
import 'package:feedvibe/presentation/post/cubits/add_post/add_post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => AdddPosPagetState();
}

class AdddPosPagetState extends State<AddPostPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Add Feed',
            style: TextStyle(
              color: AppColors.whiteColor,
            ),
          ),
          backgroundColor: AppColors.primaryBGColor,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "𝚆𝚑𝚊𝚝'𝚜 𝚘𝚗 𝚢𝚘𝚞𝚛 𝚖𝚒𝚗𝚍???",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBoxHeight25,
              TextField(
                controller: titleController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    context.read<AddPostCubit>().updateTitle(title: value);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.lightGreyColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.greyColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.lightGreyColor,
                    ),
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.all(16),
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBoxHeight16,
              TextField(
                controller: descriptionController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    context
                        .read<AddPostCubit>()
                        .updateDescription(description: value);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.lightGreyColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.greyColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.lightGreyColor,
                    ),
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.all(16),
                ),
                maxLines: 4,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBoxHeight16,
              BlocConsumer<AddPostCubit, AddPostState>(
                listener: (context, state) {
                  if (state.status == "Post uploaded successfully") {
                    titleController.clear();
                    descriptionController.clear();
                    context.read<AddPostCubit>().clearState();
                    showCustomSnackbar(context, 'Post added successfully');
                  } else if (state.failure != null) {
                    showCustomSnackbar(
                        context, state.failure!.message.toString());
                  }
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: (state.title?.isEmpty ?? true) ||
                            (state.description?.isEmpty ?? true)
                        ? null
                        : () {
                            context.read<AddPostCubit>().addPost();
                          },
                    child: Container(
                      width: 200,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: ShapeDecoration(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        color: (state.title?.isEmpty ?? true) ||
                                (state.description?.isEmpty ?? true)
                            ? AppColors.darkGreyColor
                            : AppColors.blackColor,
                      ),
                      child: state.isLoading == true
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: PlatformCircularProgressIndicator(),
                            )
                          : const Text(
                              'Post',
                              style: TextStyle(
                                color: AppColors.whiteColor,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
