import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';


class GetOwnBlogs implements UseCase<List<Blog>, OwnParams> {
	BlogRepository repository;

	GetOwnBlogs({required this.repository});

  @override
  Future<Either<Failure, List<Blog>>> call(OwnParams params) async {
		return await repository.getOwnBlogs(params.posterId);
  }
}

class OwnParams {
  String posterId;
  OwnParams({required this.posterId});
}
