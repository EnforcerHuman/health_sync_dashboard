import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:health_sync_dashboard/core/error/errors.dart';

abstract class StepsRepository {
  Future<Either<Failure, int>> getCachedSteps();

  Future<Either<Failure, int>> fetchLatestSteps();

  Future<Either<Failure, Stream<int>>> startLiveStepStream({
    Duration interval = const Duration(seconds: 2),
  });

  Future<Either<Failure, Unit>> stopLiveUpdates();
}
