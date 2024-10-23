import 'package:blog/core/utils/format_date.dart';
import 'package:blog/features/comment/domain/entity/comment.dart';
import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  final Comment comment;
  const CommentBox({super.key, required this.comment});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 70, top: 15, bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.name ?? " ",
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                Text(comment.content),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  formatDate(comment.commentedAt),
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
