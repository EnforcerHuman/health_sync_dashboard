import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_sync_dashboard/common/theme/app_theme.dart';
import 'package:health_sync_dashboard/features/health_dashboard/presentation/screens/home_screen.dart';
import 'features/health_dashboard/presentation/bloc/steps_bloc/steps_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    BlocProvider(
      create: (_) {
        final bloc = di.getIt<StepsBloc>();
        bloc.add(StartSteps());
        return bloc;
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme.lightTheme, home: const HomeScreen());
  }
}
