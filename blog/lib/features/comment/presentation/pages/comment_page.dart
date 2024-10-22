import 'package:blog/core/common/widgets/loader.dart';
import 'package:blog/core/theme/app_pallet.dart';
import 'package:blog/core/utils/show_snack_bar.dart';
import 'package:blog/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:blog/features/comment/presentation/bloc/comment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
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
            return ListView.builder(
              itemCount: state.comments.length,
              itemBuilder: (context, index) {
                return Container();
              },
            );
          } else {
            return const Center(
              child: Text("no comments"),
            );
          }
        }
        return const SizedBox();
      }),
    );
  }
}
