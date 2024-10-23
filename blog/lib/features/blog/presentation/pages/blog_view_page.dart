import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/common/cubits/app_user/app_user_state.dart';
import 'package:blog/core/utils/calculate_time.dart';
import 'package:blog/core/utils/format_date.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:blog/features/comment/presentation/bloc/comment_event.dart';
import 'package:blog/features/comment/presentation/pages/comment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogViewPage extends StatelessWidget {
  final Blog blog;
  const BlogViewPage({super.key, required this.blog});

  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewPage(blog: blog));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    height: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "by ${blog.posterName ?? ''} ",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${formatDate(blog.updatedAt)}. ${calculateTime(blog.content)} min",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(blog.imageUrl),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  blog.content,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      final userId = (context.read<AppUserCubit>().state
                              as AppUserLoggedIn)
                          .user
                          .id;
                      context
                          .read<CommentBloc>()
                          .add(FetchComment(blogId: blog.id));
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => CommentPage(
                          blogId: blog.id,
                          userId: userId,
                        ),
                      );
                    },
                    child: const Text("Comments"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
