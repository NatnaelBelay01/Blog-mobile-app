import 'package:blog/core/error/exception.dart';
import 'package:blog/core/error/failure.dart';
import 'package:blog/core/network/internet_checker.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog/core/entity/user.dart';
import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:blog/features/auth/domian/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

class AuthRepositoriesImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final InternetChecker connectionChecker;
  const AuthRepositoriesImp({
    required this.remoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!(await connectionChecker.isConnected)) {
        return left(Failure('No internet Connection'));
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user != null) {
        return right(user);
      }
      return left(Failure('User not logged in'));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => remoteDataSource.logInWithEmailPassword(
          email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(() async => remoteDataSource.signUpWithEmailPassword(
        name: name, email: email, password: password));
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!(await connectionChecker.isConnected)) {
        return left(Failure("Internet unavailable"));
      }
      final user = await fn();
      return right(user);
    } on supa.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
