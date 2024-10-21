import 'dart:io';

import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/common/cubits/app_user/app_user_state.dart';
import 'package:blog/core/common/widgets/loader.dart';
import 'package:blog/core/theme/app_pallet.dart';
import 'package:blog/core/utils/pick_image.dart';
import 'package:blog/core/utils/show_snack_bar.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presentation/bloc/blog_event.dart';
import 'package:blog/features/blog/presentation/bloc/blog_state.dart';
import 'package:blog/features/blog/presentation/pages/blog_page.dart';
import 'package:blog/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            if (formKey.currentState!.validate() &&
                image != null &&
                selectedTopics.isNotEmpty) {
              final posterId =
                  (context.read<AppUserCubit>().state as AppUserLoggedIn)
                      .user
                      .id;
              context.read<BlogBloc>().add(
                    BlogUpload(
                      image: image!,
                      content: contentController.text.trim(),
                      title: titleController.text.trim(),
                      posterId: posterId,
                      topic: selectedTopics,
                    ),
                  );
            }
          },
          icon: const Icon(Icons.done_rounded),
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<BlogBloc, BlogState>(listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.message);
          }
          if (state is BlogSuccess) {
            Navigator.pushAndRemoveUntil(
                context, BlogPage.route(), (route) => false);
          }
        }, builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  image != null
                      ? GestureDetector(
                          onTap: selectImage,
                          child: SizedBox(
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: selectImage,
                          child: DottedBorder(
                            dashPattern: const [10, 4],
                            radius: const Radius.circular(10),
                            strokeCap: StrokeCap.round,
                            borderType: BorderType.RRect,
                            color: AppPallete.borderColor,
                            child: const SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.folder_open, size: 40),
                                  SizedBox(height: 15),
                                  Text('Select your image',
                                      style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        'Technology',
                        'Business',
                        'Programming',
                        'entertainment',
                      ]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedTopics.contains(e)) {
                                    selectedTopics.remove(e);
                                  } else {
                                    selectedTopics.add(e);
                                  }
                                  setState(() {});
                                },
                                child: Chip(
                                  label: Text(e),
                                  color: selectedTopics.contains(e)
                                      ? const WidgetStatePropertyAll(
                                          AppPallete.gradient1)
                                      : null,
                                  side: selectedTopics.contains(e)
                                      ? null
                                      : const BorderSide(
                                          color: AppPallete.borderColor,
                                        ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlogEditor(
                    hintText: 'Blog title',
                    controller: titleController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlogEditor(
                    hintText: 'Blog Content',
                    controller: contentController,
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
