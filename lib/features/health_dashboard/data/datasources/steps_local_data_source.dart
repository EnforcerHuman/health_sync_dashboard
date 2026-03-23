import 'package:health_sync_dashboard/core/error/exceptions.dart';
import 'package:health_sync_dashboard/core/storage/hive_box.dart';

abstract class StepsLocalDataSource {
  Future<int> getCachedSteps();

  Future<void> cacheSteps(int steps);
}

class StepsLocalDataSourceImpl implements StepsLocalDataSource {
  StepsLocalDataSourceImpl(this._cacheService);

  final StepsCacheService _cacheService;

//this function first checks if the cache is stale and clears 
//it if necessary before reading the steps. If any error occurs during this process, 
//it throws a CacheException to be handled by the repository layer.
  @override
  Future<int> getCachedSteps() async {
    try {
      await _cacheService.clearIfStale();
      return _cacheService.readSteps();
    } catch (_) {
      throw const CacheException();
    }
  }

//This function attempts to save the provided steps to the cache.
// If any error occurs during this process, it throws a CacheException to be
// handled by the repository layer.
  @override
  Future<void> cacheSteps(int steps) async {
    try {
      await _cacheService.saveSteps(steps);
    } catch (_) {
      throw const CacheException();
    }
  }
}
