import 'package:blog/core/utils/format_date.dart';
import 'package:blog/features/comment/domain/entity/comment.dart';
import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  final Comment comment;
  const CommentBox({super.key, required this.comment});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.name ?? " ",
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            Text(comment.content),
            Text(
              formatDate(comment.commentedAt),
              style: const TextStyle(
                fontSize: 9,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
