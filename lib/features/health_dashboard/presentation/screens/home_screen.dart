import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/bloc/steps_bloc/steps_bloc.dart';
import '../steps_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<StepsBloc, StepsState>(
          builder: (context, state) {
            if (state.steps > 0 || state is! StepsInitial) {
              return Text('Steps: ${state.steps}');
            }
            return const Text('Health Dashboard');
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [StepsWidget()],
        ),
      ),
    );
  }
}
