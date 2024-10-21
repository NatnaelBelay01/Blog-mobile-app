import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/comment/domain/entity/comment.dart';
import 'package:blog/features/comment/domain/repository/comment_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoadBlogComments implements UseCase<List<Comment>, CommentParams> {
  CommentRepository repository;
  LoadBlogComments({required this.repository});
  @override
  Future<Either<Failure, List<Comment>>> call(CommentParams params) async {
    return await repository.loadBlogComments(params.blogId);
  }
}

class CommentParams {
  final String blogId;

  CommentParams({required this.blogId});
}
