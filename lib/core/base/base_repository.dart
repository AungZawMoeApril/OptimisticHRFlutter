import 'package:dartz/dartz.dart';
import '../error/failures.dart';
import '../network/network_info.dart';

abstract class BaseRepository {
  final NetworkInfo networkInfo;

  BaseRepository(this.networkInfo);

  Future<bool> get hasNetwork => networkInfo.isConnected;

  Future<Either<Failure, T>> handleError<T>(Future<T> Function() call) async {
    try {
      if (!await hasNetwork) {
        return Left(NetworkFailure());
      }
      final result = await call();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, T>> handleCache<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}