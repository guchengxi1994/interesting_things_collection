import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/isar/database.dart';

import 'database_state.dart';

class DataTableNotifier extends AutoDisposeAsyncNotifier<DatabaseState> {
  final IsarDatabase database = IsarDatabase();

  @override
  FutureOr<DatabaseState> build() async {
    final totalSize = await database.isar!.getSize();
    final details = database.getAllDetails();

    // final collections = database.isar!.;

    return DatabaseState(
        details: details, size: totalSize, databaseCount: database.schemaCount);
  }
}

final databaseNotifier =
    AutoDisposeAsyncNotifierProvider<DataTableNotifier, DatabaseState>(
        () => DataTableNotifier());
