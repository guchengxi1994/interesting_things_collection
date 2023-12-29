import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/settings/notifiers/database_state.dart';
import 'package:weaving/settings/notifiers/datatable_notifier.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:filesize/filesize.dart';

class DatabaseTable extends ConsumerWidget {
  const DatabaseTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(databaseNotifier);

    return switch (state) {
      AsyncValue<DatabaseState>(:final value?) => Builder(builder: (c) {
          return Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(64),
              1: FlexColumnWidth(),
              2: FixedColumnWidth(64),
              3: FixedColumnWidth(64),
              4: FixedColumnWidth(64),
            },
            children: [
              const TableRow(children: [
                Text("id"),
                Text("name"),
                Text("count"),
                Text("size"),
                Text("operation")
              ]),
              ...value.details.mapIndexed((i, e) => TableRow(children: [
                    Text(i.toString()),
                    Text(e.tableName),
                    Text(e.rows.toString()),
                    Text(filesize(e.size)),
                    TextButton(onPressed: () {}, child: const Text("Clear"))
                  ]))
            ],
          );
        }),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}
