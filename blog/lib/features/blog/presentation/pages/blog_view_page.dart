import 'package:blog/core/utils/calculate_time.dart';
import 'package:blog/core/utils/format_date.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
          									height: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "by ${blog.posterName ?? ''} ",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${formatDate(blog.updatedAt)}. ${calculateTime(blog.content)} min",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(blog.imageUrl),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  blog.content,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
