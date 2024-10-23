import 'package:blog/features/comment/domain/entity/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.commentId,
    required super.blogId,
    required super.userId,
    required super.content,
    required super.commentedAt,
    super.name,
  });
  factory CommentModel.fromJson(Map<String, dynamic> commentJson) {
    return CommentModel(
      commentId: commentJson["id"] as String,
      blogId: commentJson["blog_id"] as String,
      userId: commentJson["commenter_id"] as String,
      content: commentJson["content"] as String,
      commentedAt: commentJson["commented_at"] == null
          ? DateTime.now()
          : DateTime.parse(commentJson["commented_at"]),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": commentId,
      "commented_at": commentedAt.toIso8601String(),
      "content": content,
      "blog_id": blogId,
      "commenter_id": userId,
    };
  }

  CommentModel copywith({
    String? commentId,
    DateTime? commentedAt,
    String? content,
    String? userId,
    String? blogId,
    String? name,
  }) {
    return CommentModel(
      name: name ?? this.name,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      blogId: blogId ?? this.blogId,
      commentId: commentId ?? this.commentId,
      commentedAt: commentedAt ?? this.commentedAt,
    );
  }
}
