import 'package:blog/core/common/widgets/loader.dart';
import 'package:blog/core/theme/app_pallet.dart';
import 'package:blog/core/utils/show_snack_bar.dart';
import 'package:blog/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:blog/features/comment/presentation/bloc/comment_event.dart';
import 'package:blog/features/comment/presentation/bloc/comment_state.dart';
import 'package:blog/features/comment/presentation/widgets/comment_box.dart';
import 'package:blog/features/comment/presentation/widgets/comment_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentPage extends StatefulWidget {
  final String blogId;
  final String userId;
  const CommentPage({super.key, required this.blogId, required this.userId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
      ),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: const BoxDecoration(
          color: AppPallete.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child:
            BlocConsumer<CommentBloc, CommentState>(listener: (context, state) {
          if (state is CommentLoadingFailure) {
            showSnackBar(context, state.message);
          } else if (state is CommentAddingFailure) {
            showSnackBar(context, state.message);
          }
        }, builder: (context, state) {
          if (state is CommentLoading) {
            return const Loader();
          }
          if (state is CommentLoaded) {
            if (state.comments.isNotEmpty) {
              return Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) {
                        return CommentBox(
                          comment: state.comments[index],
                        );
                      },
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 280,
                          child: CommentInput(
                            controller: commentController,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<CommentBloc>().add(
                                    AddCommentEvent(
                                      blogId: widget.blogId,
                                      userId: widget.userId,
                                      content: commentController.text.trim(),
                                    ),
                                  );
                              context
                                  .read<CommentBloc>()
                                  .add(FetchComment(blogId: widget.blogId));
                              commentController.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: AppPallete.borderColor, width: 3),
                            ),
                            minimumSize: const Size(50, 70),
                          ),
                          child: const Icon(Icons.arrow_right_alt_sharp),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  const Expanded(
                    child: Center(child: Text("no comments")),
                  ),
                  Form(
                    key: formKey,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 280,
                          child: CommentInput(
                            controller: commentController,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<CommentBloc>().add(
                                    AddCommentEvent(
                                      blogId: widget.blogId,
                                      userId: widget.userId,
                                      content: commentController.text.trim(),
                                    ),
                                  );
                              context
                                  .read<CommentBloc>()
                                  .add(FetchComment(blogId: widget.blogId));
                              commentController.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: AppPallete.borderColor, width: 3),
                            ),
                            minimumSize: const Size(50, 70),
                          ),
                          child: const Icon(Icons.arrow_right_alt_sharp),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
