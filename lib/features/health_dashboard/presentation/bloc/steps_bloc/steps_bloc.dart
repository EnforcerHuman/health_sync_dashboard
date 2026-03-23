import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:health_sync_dashboard/core/services/health_services.dart';

part 'steps_event.dart';
part 'steps_state.dart';

class StepsBloc extends Bloc<StepsEvent, StepsState> {
  final HealthService _healthService;
  StreamSubscription<int>? _pollSub;

  StepsBloc(this._healthService) : super(StepsInitial()) {
    on<StartSteps>(_onStart);
    on<StopSteps>(_onStop);
    on<RefreshSteps>(_onRefresh);
    on<PermissionRequested>(_onPermissionRequested);
    on<_StepsUpdated>(_onStepsUpdated);
  }

  Future<void> _onStart(StartSteps event, Emitter<StepsState> emit) async {
    emit(StepsLoadInProgress(steps: state.steps, polling: state.polling));
    await _pollSub?.cancel();
    final stepsStream = await _healthService.startStepStream(
      interval: event.interval,
    );

    if (stepsStream == null) {
      emit(StepsPermissionDenied(steps: state.steps, polling: false));
      return;
    }

    _pollSub = stepsStream.listen((steps) {
      add(_StepsUpdated(steps));
    });
  }

  Future<void> _onStop(StopSteps event, Emitter<StepsState> emit) async {
    await _pollSub?.cancel();
    _pollSub = null;
    await _healthService.stopPolling();
    final steps = await _healthService.getStepsForToday();
    emit(StepsLoadSuccess(steps: steps, polling: false));
  }

  Future<void> _onRefresh(RefreshSteps event, Emitter<StepsState> emit) async {
    emit(StepsLoadInProgress(steps: state.steps, polling: state.polling));
    final steps = await _healthService.getStepsForToday();
    emit(StepsLoadSuccess(steps: steps, polling: state.polling));
  }

  Future<void> _onPermissionRequested(
    PermissionRequested event,
    Emitter<StepsState> emit,
  ) async {
    emit(StepsLoadInProgress(steps: state.steps, polling: state.polling));
    await _pollSub?.cancel();
    final stepsStream = await _healthService.startStepStream();

    if (stepsStream == null) {
      emit(StepsPermissionDenied(steps: state.steps, polling: false));
      return;
    }

    _pollSub = stepsStream.listen((steps) {
      add(_StepsUpdated(steps));
    });
  }

  Future<void> _onStepsUpdated(
    _StepsUpdated event,
    Emitter<StepsState> emit,
  ) async {
    emit(StepsLoadSuccess(steps: event.steps, polling: true));
  }

  @override
  Future<void> close() {
    _pollSub?.cancel();
    _healthService.stopPolling();
    return super.close();
  }
}
