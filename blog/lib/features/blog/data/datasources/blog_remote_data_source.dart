import 'package:blog/core/error/exception.dart';
import 'package:blog/features/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
}

class BlogRemoteDataSourceImp extends BlogRemoteDataSource {
  final SupabaseClient supabase;

  BlogRemoteDataSourceImp({required this.supabase});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
		try {
			final blogData = await supabase.from('blogs').insert(blog.toJson()).select();
			return BlogModel.fromJson(blogData.first);
		} catch (e) {
			throw ServerException(message: e.toString());
		}
	}
}
