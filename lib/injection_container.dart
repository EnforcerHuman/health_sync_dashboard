import 'package:get_it/get_it.dart';

import 'core/services/health_services.dart';
import 'features/health_dashboard/presentation/bloc/steps_bloc/steps_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
	// Register services
	getIt.registerLazySingleton<HealthService>(() => HealthService());

	// Register blocs/factories
	getIt.registerFactory<StepsBloc>(() => StepsBloc(getIt<HealthService>()));

  // If you had other blocs or services, you'd register them here similarly.
}
