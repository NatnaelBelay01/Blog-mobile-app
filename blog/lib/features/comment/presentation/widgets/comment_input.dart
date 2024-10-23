import 'package:flutter/material.dart';

class CommentInput extends StatelessWidget {
  final TextEditingController controller;
  const CommentInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'add comment',
      ),
      maxLines: 1,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return 'comment is empty';
        }
        return null;
      },
    );
  }
}
