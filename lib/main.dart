import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_sync_dashboard/features/health_dashboard/presentation/screens/home_screen.dart';
import 'features/health_dashboard/presentation/bloc/steps_bloc/steps_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    // Provide StepsBloc at the top-level so the AppBar can read step counts.
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
  theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
    );
  }
}
