import 'package:dartz/dartz.dart';
import 'package:health_sync_dashboard/core/error/errors.dart';
import 'package:health_sync_dashboard/features/health_dashboard/domain/repositories/steps_repository.dart';

class GetCachedSteps {
  GetCachedSteps(this._repository);

  final StepsRepository _repository;

  Future<Either<Failure, int>> call() {
    return _repository.getCachedSteps();
  }
}
