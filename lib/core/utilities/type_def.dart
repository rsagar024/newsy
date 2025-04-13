import 'package:fpdart/fpdart.dart';
import 'package:newsy_app/core/error/failure.dart';

typedef FutureEitherFailure<T> = Future<Either<Failure, T>>;
