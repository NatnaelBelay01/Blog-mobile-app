import 'dart:io';

import 'package:blog/core/error/failure.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topic,
  });

	Future<Either<Failure, List<Blog>>> getAllBlogs();
	Future<Either<Failure, List<Blog>>> getOwnBlogs(String posterId);
}
