import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:health_sync_dashboard/core/error/errors.dart';
import 'package:health_sync_dashboard/core/error/exceptions.dart';
import 'package:health_sync_dashboard/features/health_dashboard/data/datasources/steps_local_data_source.dart';
import 'package:health_sync_dashboard/features/health_dashboard/data/datasources/steps_remote_data_source.dart';
import 'package:health_sync_dashboard/features/health_dashboard/domain/repositories/steps_repository.dart';

class StepsRepositoryImpl implements StepsRepository {
  StepsRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final StepsRemoteDataSource _remoteDataSource;
  final StepsLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, int>> getCachedSteps() async {
    try {
      final steps = await _localDataSource.getCachedSteps();
      return Right(steps);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> fetchLatestSteps() async {
    try {
      final steps = await _remoteDataSource.fetchLatestSteps();
      await _localDataSource.cacheSteps(steps);
      return Right(steps);
    } on PermissionException catch (e) {
      return Left(PermissionFailure(e.message));
    } on HealthException catch (e) {
      return Left(HealthFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Stream<int>>> startLiveStepStream({
    Duration interval = const Duration(seconds: 2),
  }) async {
    try {
      final stream = await _remoteDataSource.startLiveStepStream(
        interval: interval,
      );

      return Right(
        stream.asyncMap((steps) async {
          await _localDataSource.cacheSteps(steps);
          return steps;
        }),
      );
    } on PermissionException catch (e) {
      return Left(PermissionFailure(e.message));
    } on HealthException catch (e) {
      return Left(HealthFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> stopLiveUpdates() async {
    try {
      await _remoteDataSource.stopLiveUpdates();
      return right(unit);
    } on HealthException catch (e) {
      return Left(HealthFailure(e.message));
    }
  }
}
