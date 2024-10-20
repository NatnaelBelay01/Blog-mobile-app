import 'dart:io';

import 'package:blog/core/error/exception.dart';
import 'package:blog/core/error/failure.dart';
import 'package:blog/core/network/internet_checker.dart';
import 'package:blog/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/model/blog_model.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImp implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;
  final BlogLocalDataSource localDataSource;
  final InternetChecker internetChecker;
  BlogRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.internetChecker,
  });
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topic,
  }) async {
    try {
			if(!(await internetChecker.isConnected)){
				return left(Failure('no internet connection'));
			}
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topic: topic,
        updatedAt: DateTime.now(),
      );
      final imgUrl =
          await remoteDataSource.uploadImage(blog: blogModel, image: image);
      blogModel = blogModel.copyWith(imageUrl: imgUrl);
      final upToDateBlog = await remoteDataSource.uploadBlog(blogModel);
      return right(upToDateBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
			if(!(await internetChecker.isConnected)){
				final blogList = localDataSource.loadBlogs();
				return right(blogList);
			}
      final blogList = await remoteDataSource.getAllBlogs();
			localDataSource.uploadLocalBlogs(blogs: blogList);
      return right(blogList);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
