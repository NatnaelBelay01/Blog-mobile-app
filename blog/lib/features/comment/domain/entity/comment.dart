class Comment {
  final String commentId;
  final String blogId;
  final String userId;
	final String content;
	final DateTime commentedAt;
	final String? name;

  Comment({
    required this.commentId,
    required this.blogId,
    required this.userId,
		required this.content,
		required this.commentedAt,
		this.name,
  });
}
