import 'package:blog/features/comment/data/model/comment_model.dart';

abstract interface class CommentRemoteDataSource {
	Future<CommentModel> uploadComment(CommentModel commentModel);
	Future<List<CommentModel>> loadComments(String blogId);
}
