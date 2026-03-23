abstract class Failure {
  const Failure(this.message);

  final String message;
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Failed to access cached steps.']);
}

class HealthFailure extends Failure {
  const HealthFailure([super.message = 'Failed to fetch health steps data.']);
}

class PermissionFailure extends Failure {
  const PermissionFailure([
    super.message = 'Health permission was denied or unavailable.',
  ]);
}
