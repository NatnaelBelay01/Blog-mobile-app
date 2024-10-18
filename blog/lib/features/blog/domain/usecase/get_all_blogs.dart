import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  BlogRepository repository;

  GetAllBlogs({required this.repository});
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await repository.getAllBlogs();
  }
}
