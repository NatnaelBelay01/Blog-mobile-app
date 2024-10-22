import 'package:blog/core/error/exception.dart';
import 'package:blog/core/error/failure.dart';
import 'package:blog/features/comment/data/datasource/comment_remote_data_source.dart';
import 'package:blog/features/comment/data/model/comment_model.dart';
import 'package:blog/features/comment/domain/entity/comment.dart';
import 'package:blog/features/comment/domain/repository/comment_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class CommentRepositoryImp implements CommentRepository {
  CommentRemoteDataSource remoteDataSource;
  CommentRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, Comment>> addComment({
    required String content,
    required String blogId,
    required String userId,
  }) async {
    try {
      final CommentModel comment = CommentModel(
        commentId: const Uuid().v1(),
        content: content,
        blogId: blogId,
        userId: userId,
				commentedAt: DateTime.now()
      );

      final res = await remoteDataSource.uploadComment(comment);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> loadBlogComments(String blogId) async {
    try {
      final res = await remoteDataSource.loadComments(blogId);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
