part of 'steps_bloc.dart';

abstract class StepsState {
  final int steps;
  final bool polling;

  const StepsState({this.steps = 0, this.polling = false});
}

class StepsInitial extends StepsState {
  const StepsInitial();
}

class StepsLoadInProgress extends StepsState {
  const StepsLoadInProgress({required super.steps, required super.polling});
}

class StepsLoadSuccess extends StepsState {
  const StepsLoadSuccess({required super.steps, required super.polling});
}

class StepsPermissionDenied extends StepsState {
  const StepsPermissionDenied({required super.steps, required super.polling});
}
