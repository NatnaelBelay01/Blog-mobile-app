class Comment {
  final String commentId;
  final String blogId;
  final String userId;
	final String content;
	final DateTime commentedAt;

  Comment({
    required this.commentId,
    required this.blogId,
    required this.userId,
		required this.content,
		required this.commentedAt,
  });
}
