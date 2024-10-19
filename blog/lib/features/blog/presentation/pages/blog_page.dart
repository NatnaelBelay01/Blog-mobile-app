import 'package:blog/core/common/widgets/loader.dart';
import 'package:blog/core/theme/app_pallet.dart';
import 'package:blog/core/utils/show_snack_bar.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presentation/bloc/blog_event.dart';
import 'package:blog/features/blog/presentation/bloc/blog_state.dart';
import 'package:blog/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
	final List<Color> colors = [AppPallete.gradient1, AppPallete.gradient2, AppPallete.gradient3];
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogLoadAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
            ),
            Text('Blog App'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: const Icon(CupertinoIcons.add_circled),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(listener: (context, state) {
        if (state is BlogFailure) {
          showSnackBar(context, state.message);
        }
      }, builder: (context, state) {
        if (state is BlogLoading) {
          return const Loader();
        }
        if (state is BlogLoadSuccess) {
          return ListView.builder(
            itemCount: state.blogList.length,
            itemBuilder: (context, index) {
              return BlogCard(
                blog: state.blogList[index],
                color: colors[index % 3],
              );
            },
          );
        }
        return const SizedBox();
      }),
    );
  }
}
