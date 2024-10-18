import 'dart:io';

import 'package:blog/core/error/exception.dart';
import 'package:blog/features/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadImage({
    required File image,
    required BlogModel blog,
  });
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImp implements BlogRemoteDataSource {
  final SupabaseClient supabase;

  BlogRemoteDataSourceImp({required this.supabase});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabase.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabase.storage.from('blog_images').upload(blog.id, image);
      return supabase.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final result = await supabase.from('blogs').select('*, profiles (name)');
      final List<BlogModel> blogList = result
          .map(
            (val) => BlogModel.fromJson(val)
                .copyWith(posterName: val['profiles']['name']),
          )
          .toList();

      return blogList;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
