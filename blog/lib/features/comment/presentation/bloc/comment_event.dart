class CommentEvent {}

class AddCommentEvent extends CommentEvent {
  final String userId;
  final String blogId;
  final String content;

  AddCommentEvent({
    required this.blogId,
    required this.userId,
    required this.content,
  });
}

class FetchComment extends CommentEvent {
  final String blogId;
  FetchComment({required this.blogId});
}
