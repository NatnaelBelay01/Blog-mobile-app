import 'package:blog/core/error/exception.dart';
import 'package:blog/core/error/failure.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog/features/auth/domian/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoriesImp implements AuthRepository {
	final AuthRemoteDataSource remoteDataSource;
	const AuthRepositoriesImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> logInWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement logInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
		try {
			final result = await remoteDataSource.signUpWithEmailPassword(name: name, email: email, password: password);
			return right(result);
		} on ServerException catch (e) {
			return left(Failure(e.message));
		}
	}
}
