import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:health_sync_dashboard/core/error/errors.dart';
import 'package:health_sync_dashboard/features/health_dashboard/domain/repositories/steps_repository.dart';

class StartLiveStepStream {
  StartLiveStepStream(this._repository);

  final StepsRepository _repository;

  Future<Either<Failure, Stream<int>>> call({
    Duration interval = const Duration(seconds: 2),
  }) {
    return _repository.startLiveStepStream(interval: interval);
  }
}
