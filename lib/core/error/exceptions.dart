class CacheException implements Exception {
  const CacheException([this.message = 'Failed to access cache.']);

  final String message;
}

class HealthException implements Exception {
  const HealthException([this.message = 'Failed to access health data.']);

  final String message;
}

class PermissionException implements Exception {
  const PermissionException([this.message = 'Permission denied.']);

  final String message;
}
