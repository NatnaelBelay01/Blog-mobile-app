import 'package:blog/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
					mainAxisAlignment: MainAxisAlignment.center,
          children: [
						SizedBox(width: 30,),
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
    );
  }
}
