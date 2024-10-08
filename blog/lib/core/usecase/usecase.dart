import 'package:blog/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<successType, Params> {
  Future<Either<Failure, successType>> call(Params params);
}
