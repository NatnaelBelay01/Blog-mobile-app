import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domian/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<String, Params> {
  final AuthRepository repository;
  UserSignUp({required this.repository});
  @override
  Future<Either<Failure, String>> call(params) async {
    return await repository.signUpWithEmailPassword(
      email: params.email,
      name: params.name,
      password: params.password,
    );
  }
}

class Params {
  String email;
  String password;
  String name;

  Params({required this.email, required this.name, required this.password});
}
