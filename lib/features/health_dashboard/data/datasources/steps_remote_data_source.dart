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

  @override
  Future<int> fetchLatestSteps() async {
    try {
      return await _healthService.getStepsForToday();
    } catch (_) {
      throw const HealthException();
    }
  }

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

  @override
  Future<void> stopLiveUpdates() async {
    try {
      await _healthService.stopPolling();
    } catch (_) {
      throw const HealthException();
    }
  }
}
