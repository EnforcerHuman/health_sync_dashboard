import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:health_sync_dashboard/core/error/errors.dart';
import 'package:health_sync_dashboard/core/error/exceptions.dart';

import 'package:health_sync_dashboard/features/health_dashboard/domain/usecases/fetch_latest_steps.dart';
import 'package:health_sync_dashboard/features/health_dashboard/domain/usecases/get_cached_steps.dart';
import 'package:health_sync_dashboard/features/health_dashboard/domain/usecases/start_live_step_stream.dart';
import 'package:health_sync_dashboard/features/health_dashboard/domain/usecases/stop_live_updates.dart';

part 'steps_event.dart';
part 'steps_state.dart';

class StepsBloc extends Bloc<StepsEvent, StepsState> {
  final GetCachedSteps _getCachedSteps;
  final FetchLatestSteps _fetchLatestSteps;
  final StartLiveStepStream _startLiveStepStream;
  final StopLiveUpdates _stopLiveUpdates;
  StreamSubscription<int>? _pollSub;

  StepsBloc({
    required GetCachedSteps getCachedSteps,
    required FetchLatestSteps fetchLatestSteps,
    required StartLiveStepStream startLiveStepStream,
    required StopLiveUpdates stopLiveUpdates,
  }) : _getCachedSteps = getCachedSteps,
       _fetchLatestSteps = fetchLatestSteps,
       _startLiveStepStream = startLiveStepStream,
       _stopLiveUpdates = stopLiveUpdates,
       super(StepsInitial()) {
    on<StartSteps>(_onStart);
    on<StopSteps>(_onStop);
    on<RefreshSteps>(_onRefresh);
    on<PermissionRequested>(_onPermissionRequested);
    on<_StepsUpdated>(_onStepsUpdated);
    on<_StepsStreamFailed>(_onStepsStreamFailed);
  }

  Future<void> _onStart(StartSteps event, Emitter<StepsState> emit) async {
    emit(StepsLoadInProgress(steps: state.steps, polling: state.polling));
    final cachedSteps = (await _getCachedSteps()).fold(
      (_) => state.steps,
      (r) => r,
    );
    if (cachedSteps > 0) {
      emit(StepsLoadSuccess(steps: cachedSteps, polling: false));
    }

    await _pollSub?.cancel();
    final streamResult = await _startLiveStepStream(interval: event.interval);
    streamResult.fold((failure) => _emitFailure(failure, emit, cachedSteps), (
      stepsStream,
    ) {
      _pollSub = stepsStream.listen(
        (steps) {
          add(_StepsUpdated(steps));
        },
        onError: (error, _) {
          add(_StepsStreamFailed(_mapStreamError(error)));
        },
      );
    });
  }

  Future<void> _onStop(StopSteps event, Emitter<StepsState> emit) async {
    await _pollSub?.cancel();
    _pollSub = null;
    await _stopLiveUpdates();
    final latestResult = await _fetchLatestSteps();
    latestResult.fold(
      (_) => emit(StepsLoadSuccess(steps: state.steps, polling: false)),
      (steps) => emit(StepsLoadSuccess(steps: steps, polling: false)),
    );
  }

  Future<void> _onRefresh(RefreshSteps event, Emitter<StepsState> emit) async {
    emit(StepsLoadInProgress(steps: state.steps, polling: state.polling));
    final latestResult = await _fetchLatestSteps();
    latestResult.fold(
      (_) => emit(StepsLoadSuccess(steps: state.steps, polling: state.polling)),
      (steps) => emit(StepsLoadSuccess(steps: steps, polling: state.polling)),
    );
  }

  Future<void> _onPermissionRequested(
    PermissionRequested event,
    Emitter<StepsState> emit,
  ) async {
    emit(StepsLoadInProgress(steps: state.steps, polling: state.polling));
    await _pollSub?.cancel();
    final streamResult = await _startLiveStepStream();
    streamResult.fold((failure) => _emitFailure(failure, emit, state.steps), (
      stepsStream,
    ) {
      _pollSub = stepsStream.listen(
        (steps) {
          add(_StepsUpdated(steps));
        },
        onError: (error, _) {
          add(_StepsStreamFailed(_mapStreamError(error)));
        },
      );
    });
  }

  Future<void> _onStepsUpdated(
    _StepsUpdated event,
    Emitter<StepsState> emit,
  ) async {
    emit(StepsLoadSuccess(steps: event.steps, polling: true));
  }

  Future<void> _onStepsStreamFailed(
    _StepsStreamFailed event,
    Emitter<StepsState> emit,
  ) async {
    await _pollSub?.cancel();
    _pollSub = null;
    await _stopLiveUpdates();
    _emitFailure(event.failure, emit, state.steps);
  }

  void _emitFailure(Failure failure, Emitter<StepsState> emit, int steps) {
    if (failure is PermissionFailure) {
      emit(StepsPermissionDenied(steps: steps, polling: false));
      return;
    }

    emit(StepsLoadSuccess(steps: steps, polling: false));
  }

  Failure _mapStreamError(Object error) {
    if (error is PermissionException) {
      return PermissionFailure(error.message);
    }
    if (error is HealthException) {
      return HealthFailure(error.message);
    }
    if (error is CacheException) {
      return CacheFailure(error.message);
    }
    return const HealthFailure();
  }

  @override
  Future<void> close() async {
    await _pollSub?.cancel();
    await _stopLiveUpdates();
    return super.close();
  }
}
