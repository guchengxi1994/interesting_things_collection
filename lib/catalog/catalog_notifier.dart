import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/common/app_params.dart';
import 'package:interesting_things_collection/isar/catalog.dart';
import 'package:interesting_things_collection/isar/database.dart';
import 'package:isar/isar.dart';

class CatalogNotifier extends ChangeNotifier {
  final IsarDatabase database = IsarDatabase();

  newCatalog(String name, {String? remark}) async {
    final newCatalog = Catalog()
      ..createdAt = DateTime.now().millisecondsSinceEpoch
      ..name = name
      ..remark = remark;

    await database.isar!.writeTxn(() async {
      await database.isar!.catalogs.put(newCatalog);
    });
  }

  final StreamController<Set<Catalog>> streamController =
      StreamController.broadcast();

  Set<Catalog> datas = {};

  queryAll() async {
    int pageCount = 1;
    while (true) {
      List<Catalog> catalogs = await database.isar!.catalogs
          .where()
          .offset((pageCount - 1) * AppParams.databaseQueryPageSize)
          .limit(AppParams.databaseQueryPageSize)
          .findAll();

      datas.addAll(catalogs);

      streamController.sink.add(datas);

      if (catalogs.length < AppParams.databaseQueryPageSize) {
        break;
      } else {
        pageCount += 1;
      }
    }

    print(database.isar!.catalogs.countSync());
  }

  int onHoverCatalogId = -1;

  changeOnHoverCatalogId(int id) {
    if (id != onHoverCatalogId) {
      onHoverCatalogId = id;
      notifyListeners();
    }
  }
}

final catalogNotifier = ChangeNotifierProvider((ref) => CatalogNotifier());
