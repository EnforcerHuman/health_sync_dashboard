import 'package:get_it/get_it.dart';

import 'core/services/health_services.dart';
import 'features/health_dashboard/presentation/bloc/steps_bloc/steps_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<HealthService>(() => HealthService());

  getIt.registerFactory<StepsBloc>(() => StepsBloc(getIt<HealthService>()));
}
