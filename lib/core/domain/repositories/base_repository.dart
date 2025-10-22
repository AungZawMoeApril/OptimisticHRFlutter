import 'package:dartz/dartz.dart';
import '../error/failures.dart';

abstract class Repository<T> {
  Future<Either<Failure, List<T>>> getAll();
  Future<Either<Failure, T>> getById(String id);
  Future<Either<Failure, T>> create(T item);
  Future<Either<Failure, T>> update(T item);
  Future<Either<Failure, bool>> delete(String id);
}