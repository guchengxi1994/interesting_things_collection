import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/isar/catalog.dart';
import 'package:interesting_things_collection/isar/thing.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabaseNotifier extends ChangeNotifier {
  // ignore: avoid_init_to_null
  late Isar? isar = null;

  init() async {
    if (isar != null && isar!.isOpen) {
      return;
    }
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [CatalogSchema, ThingSchema],
      directory: dir.path,
    );
  }

  newCatalog() async {
    final newCatalog = Catalog()
      ..createdAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = 0
      ..name = "aaa"
      ..remark = "bbb";

    await isar!.writeTxn(() async {
      await isar!.catalogs.put(newCatalog);
    });

    await isar!.writeTxn(() async {
      print(await isar!.catalogs.count());
    });
  }
}

final isarDatabaseNotifier =
    ChangeNotifierProvider((ref) => IsarDatabaseNotifier());
