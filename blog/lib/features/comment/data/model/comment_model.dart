import 'package:blog/features/comment/domain/entity/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.commentId,
    required super.blogId,
    required super.userId,
		required super.content,
  });

}
