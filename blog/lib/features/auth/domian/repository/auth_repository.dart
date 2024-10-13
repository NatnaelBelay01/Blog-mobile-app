import 'package:blog/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../entity/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> logInWithEmailPassword({
    required String email,
    required String password,
  });

	Future<Either<Failure, User>> currentUser();
}
