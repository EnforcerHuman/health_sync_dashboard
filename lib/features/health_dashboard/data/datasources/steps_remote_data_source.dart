import 'dart:async';

import 'package:health_sync_dashboard/core/error/exceptions.dart';
import 'package:health_sync_dashboard/core/services/health_services.dart';

abstract class StepsRemoteDataSource {
  Future<int> fetchLatestSteps();

  Future<Stream<int>> startLiveStepStream({
    Duration interval = const Duration(seconds: 2),
  });

  Future<void> stopLiveUpdates();
}

class StepsRemoteDataSourceImpl implements StepsRemoteDataSource {
  StepsRemoteDataSourceImpl(this._healthService);

  final HealthService _healthService;


// The `fetchLatestSteps` method attempts to retrieve the latest step count 
//for the current day using the `_healthService`. If any error occurs during this process,
// it catches the exception and throws a `HealthException` to be handled by the repository layer.
  @override
  Future<int> fetchLatestSteps() async {
    try {
      return await _healthService.getStepsForToday();
    } catch (_) {
      throw const HealthException();
    }
  }


// The `startLiveStepStream` method attempts to start a stream of step count
// updates at the specified interval using the `_healthService`.
  @override
  Future<Stream<int>> startLiveStepStream({
    Duration interval = const Duration(seconds: 2),
  }) async {
    try {
      final stream = await _healthService.startStepStream(interval: interval);
      if (stream == null) {
        throw const PermissionException();
      }

      return stream;
    } on PermissionException {
      rethrow;
    } catch (_) {
      throw const HealthException();
    }
  }

// The `stopLiveUpdates` method attempts to stop the live step updates by calling the 
//`stopPolling` method of the `_healthService`. If any error occurs during this process,
// it catches the exception and throws a `HealthException` to be handled by the repository layer.
  @override
  Future<void> stopLiveUpdates() async {
    try {
      await _healthService.stopPolling();
    } catch (_) {
      throw const HealthException();
    }
  }
}
