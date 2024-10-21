import 'package:blog/core/error/failure.dart';
import 'package:blog/features/comment/domain/entity/comment.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CommentRepository {
  Future<Either<Failure, Comment>> addComment(Comment comment);
  Future<Either<Failure, List<Comment>>> loadBlogComments(String blogId);
}
