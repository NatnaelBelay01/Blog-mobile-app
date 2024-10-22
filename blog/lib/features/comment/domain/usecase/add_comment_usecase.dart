import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/comment/domain/entity/comment.dart';
import 'package:blog/features/comment/domain/repository/comment_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddComment implements UseCase<Comment, AddCommentParam> {
  CommentRepository repository;
  AddComment({required this.repository});
  @override
  Future<Either<Failure, Comment>> call(AddCommentParam params) async {
    return await repository.addComment(
      userId: params.userId,
      blogId: params.blogId,
      content: params.content,
    );
  }
}

class AddCommentParam {
  final String content;
  final String userId;
  final String blogId;

  AddCommentParam({
    required this.content,
    required this.userId,
    required this.blogId,
  });
}
