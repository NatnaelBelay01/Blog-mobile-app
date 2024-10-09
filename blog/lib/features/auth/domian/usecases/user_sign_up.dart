import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domian/entity/user.dart';
import 'package:blog/features/auth/domian/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository repository;
  UserSignUp({required this.repository});
  @override
  Future<Either<Failure, User>> call(params) async {
    return await repository.signUpWithEmailPassword(
      email: params.email,
      name: params.name,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams({required this.email, required this.name, required this.password});
}
