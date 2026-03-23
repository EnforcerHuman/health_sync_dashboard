part of 'steps_bloc.dart';

abstract class StepsEvent {}

class StartSteps extends StepsEvent {
  final Duration interval;
  StartSteps({this.interval = const Duration(seconds: 2)});
}

class StopSteps extends StepsEvent {}

class RefreshSteps extends StepsEvent {}

class PermissionRequested extends StepsEvent {}

// Internal event used by the bloc when new data arrives from the service.
class _StepsUpdated extends StepsEvent {
  final int steps;
  _StepsUpdated(this.steps);
}
