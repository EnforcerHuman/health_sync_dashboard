import 'package:health_sync_dashboard/core/error/exceptions.dart';
import 'package:health_sync_dashboard/core/services/storage.dart/hive_box.dart';

abstract class StepsLocalDataSource {
  Future<int> getCachedSteps();

  Future<void> cacheSteps(int steps);
}

class StepsLocalDataSourceImpl implements StepsLocalDataSource {
  StepsLocalDataSourceImpl(this._cacheService);

  final StepsCacheService _cacheService;

  @override
  Future<int> getCachedSteps() async {
    try {
      await _cacheService.clearIfStale();
      return _cacheService.readSteps();
    } catch (_) {
      throw const CacheException();
    }
  }

  @override
  Future<void> cacheSteps(int steps) async {
    try {
      await _cacheService.saveSteps(steps);
    } catch (_) {
      throw const CacheException();
    }
  }
}
