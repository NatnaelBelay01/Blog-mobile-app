import 'package:blog/core/error/exception.dart';
import 'package:blog/features/comment/data/model/comment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CommentRemoteDataSource {
  Future<CommentModel> uploadComment(CommentModel commentModel);
  Future<List<CommentModel>> loadComments(String blogId);
}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final SupabaseClient supabase;
  CommentRemoteDataSourceImpl({required this.supabase});

  @override
  Future<List<CommentModel>> loadComments(String blogId) async {
    try {
      final res = await supabase
          .from("comments")
          .select('*, profiles (name)')
          .eq('blog_id', blogId);
      final commentList = res
          .map(
            (value) => CommentModel.fromJson(value)
                .copywith(name: value['profiles']['name']),
          )
          .toList();
      return commentList.reversed.toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<CommentModel> uploadComment(CommentModel commentModel) async {
    try {
      final res = await supabase
          .from('comments')
          .insert(commentModel.toJson())
          .select();
      return CommentModel.fromJson(res.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
