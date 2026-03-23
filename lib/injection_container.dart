import 'package:get_it/get_it.dart';

import 'core/services/health_services.dart';
import 'core/services/storage.dart/hive_box.dart';
import 'core/services/storage.dart/hive_init.dart';
import 'features/health_dashboard/data/datasources/steps_local_data_source.dart';
import 'features/health_dashboard/data/datasources/steps_remote_data_source.dart';
import 'features/health_dashboard/data/repositories/steps_repository_impl.dart';
import 'features/health_dashboard/domain/repositories/steps_repository.dart';
import 'features/health_dashboard/domain/usecases/fetch_latest_steps.dart';
import 'features/health_dashboard/domain/usecases/get_cached_steps.dart';
import 'features/health_dashboard/domain/usecases/start_live_step_stream.dart';
import 'features/health_dashboard/domain/usecases/stop_live_updates.dart';
import 'features/health_dashboard/presentation/bloc/steps_bloc/steps_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final hiveInit = HiveInit();
  await hiveInit.initialize();

  getIt.registerLazySingleton<HiveInit>(() => hiveInit);
  getIt.registerLazySingleton<HealthService>(() => HealthService());
  getIt.registerLazySingleton<StepsCacheService>(() => StepsCacheService());
  getIt.registerLazySingleton<StepsLocalDataSource>(
    () => StepsLocalDataSourceImpl(getIt<StepsCacheService>()),
  );
  getIt.registerLazySingleton<StepsRemoteDataSource>(
    () => StepsRemoteDataSourceImpl(getIt<HealthService>()),
  );
  getIt.registerLazySingleton<StepsRepository>(
    () => StepsRepositoryImpl(
      getIt<StepsRemoteDataSource>(),
      getIt<StepsLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetCachedSteps>(
    () => GetCachedSteps(getIt<StepsRepository>()),
  );
  getIt.registerLazySingleton<FetchLatestSteps>(
    () => FetchLatestSteps(getIt<StepsRepository>()),
  );
  getIt.registerLazySingleton<StartLiveStepStream>(
    () => StartLiveStepStream(getIt<StepsRepository>()),
  );
  getIt.registerLazySingleton<StopLiveUpdates>(
    () => StopLiveUpdates(getIt<StepsRepository>()),
  );

  getIt.registerFactory<StepsBloc>(
    () => StepsBloc(
      getCachedSteps: getIt<GetCachedSteps>(),
      fetchLatestSteps: getIt<FetchLatestSteps>(),
      startLiveStepStream: getIt<StartLiveStepStream>(),
      stopLiveUpdates: getIt<StopLiveUpdates>(),
    ),
  );
}
