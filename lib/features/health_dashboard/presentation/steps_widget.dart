import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/steps_bloc/steps_bloc.dart';

/// Widget that displays today's step count using the provided StepsBloc.
class StepsWidget extends StatelessWidget {
  const StepsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<StepsBloc, StepsState>(
          builder: (context, state) {
            final steps = state.steps;
            final polling = state.polling;
            final isLoading = state is StepsLoadInProgress;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Today\'s steps',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Text(
                  '$steps',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          context.read<StepsBloc>().add(RefreshSteps()),
                      child: const Text('Refresh'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<StepsBloc>().add(PermissionRequested()),
                      child: const Text('Request Permission'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  isLoading
                      ? 'Updating...'
                      : (polling ? 'Auto-updating' : 'Not updating'),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (state is StepsPermissionDenied) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Permission denied. Please enable permissions in system settings.',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
