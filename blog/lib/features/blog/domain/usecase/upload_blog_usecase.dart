import 'dart:io';

import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, BlogParams> {
  final BlogRepository repository;
  const UploadBlog({required this.repository});
  @override
  Future<Either<Failure, Blog>> call(BlogParams params) async {
    final result = await repository.uploadBlog(
      posterId: params.posterId,
      title: params.title,
      image: params.image,
      content: params.content,
      topic: params.topic,
    );

		return result;
  }
}

class BlogParams {
  final String posterId;
  final String title;
  final String content;
  final List<String> topic;
  final File image;

  BlogParams(
      {required this.posterId,
      required this.title,
      required this.content,
      required this.topic,
      required this.image});
}
