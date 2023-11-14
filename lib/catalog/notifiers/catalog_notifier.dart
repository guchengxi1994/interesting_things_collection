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
      ..orderNum = 0
      ..remark = remark;

    await database.isar!.writeTxn(() async {
      await database.isar!.catalogs.put(newCatalog);
    });

    queryAll();
  }

  final StreamController<Set<Catalog>> streamController =
      StreamController.broadcast();

  Set<Catalog> datas = {};

  queryAll() async {
    int pageCount = 1;
    while (true) {
      List<Catalog> catalogs = await database.isar!.catalogs
          .where()
          .sortByOrderNum()
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
  }

  int onHoverCatalogId = -1;

  changeOnHoverCatalogId(int id) {
    if (id != onHoverCatalogId) {
      onHoverCatalogId = id;
      notifyListeners();
    }
  }

  deleteCatalog(int id) async {
    final catalog = datas.elementAt(id);

    await database.isar!.writeTxn(() async {
      final b = await database.isar!.catalogs.delete(catalog.id);
      datas.removeWhere(
        (element) => element.id == catalog.id,
      );
      if (b) {
        streamController.sink.add(datas);
      }
    });
  }

  changeIndex(int oldIndex, int newIndex) async {
    await database.isar!.writeTxn(() async {
      final item = datas.elementAt(oldIndex);

      if (oldIndex > newIndex) {
        // 从后往前
        item.orderNum = datas.elementAt(newIndex).orderNum! - 1;
        for (int i = 0; i < newIndex; i++) {
          final before = datas.elementAt(i);
          if (before != item) {
            before.orderNum = before.orderNum! - 1;
            await database.isar!.catalogs.put(before);
          }
        }
      } else {
        // 从前往后
        item.orderNum = datas.elementAt(newIndex).orderNum! + 1;

        for (int j = newIndex + 1; j < datas.length; j++) {
          final after = datas.elementAt(j);
          if (after != item) {
            after.orderNum = after.orderNum! + 1;
            await database.isar!.catalogs.put(after);
          }
        }
      }

      await database.isar!.catalogs.put(item);
    });
    datas.clear();
    queryAll();
  }
}

final catalogNotifier = ChangeNotifierProvider((ref) => CatalogNotifier());
