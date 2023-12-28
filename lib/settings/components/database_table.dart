import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/settings/notifiers/database_state.dart';
import 'package:weaving/settings/notifiers/datatable_notifier.dart';

class DatabaseTable extends ConsumerWidget {
  const DatabaseTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(databaseNotifier);

    return switch (state) {
      AsyncValue<DatabaseState>(:final value?) => Builder(builder: (c) {
          print(value.databaseCount);
          print(value.size);

          return Container();
        }),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}
