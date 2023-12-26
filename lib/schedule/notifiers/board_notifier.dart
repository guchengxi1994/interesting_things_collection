import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:weaving/isar/database.dart';
import 'package:weaving/isar/kanban.dart';

import 'board_notifier_state.dart';

class BoardNotifier extends AsyncNotifier<BoardNotifierState> {
  final database = IsarDatabase();

  @override
  FutureOr<BoardNotifierState> build() async {
    final list = await database.isar!.kanbanDatas.where().findAll();

    final pending = list.where((element) => element.name == "Pending").first;
    final underGoing =
        list.where((element) => element.name == "In progress").first;

    List<KanbanItem> shouldRemove = [];

    for (final i in underGoing.items) {
      if (_deadline(i.deadline)) {
        i.status = ItemStatus.pending;
        // underGoing.items.remove(i);
        // pending.items.add(i);
        shouldRemove.add(i);

        database.isar!.writeTxnSync(() {
          database.isar!.kanbanItems.putSync(i);
        });
      }
    }

    underGoing.items.removeAll(shouldRemove);
    pending.items.addAll(shouldRemove);

    await database.isar!.writeTxn(
      () async {
        await pending.items.save();
        await underGoing.items.save();
      },
    );

    return BoardNotifierState(kanbanData: list);
  }

  Future changeStatus(int id) async {
    state = const AsyncLoading();

    KanbanItem? item =
        await database.isar!.kanbanItems.where().idEqualTo(id).findFirst();
    if (item == null) {
      state = state;
      return;
    }
    final list = state.value!.kanbanData;

    state = await AsyncValue.guard(() async {
      final underGoing =
          list.where((element) => element.name == "In progress").first;
      final done = list.where((element) => element.name == "Done").first;

      await database.isar!.writeTxn(() async {
        if (item.status == ItemStatus.done) {
          item.status = ItemStatus.inProgress;
          underGoing.items.add(item);
          done.items.remove(item);
        } else {
          item.status = ItemStatus.done;
          underGoing.items.remove(item);
          done.items.add(item);
        }

        await database.isar!.kanbanItems.put(item);
        await done.items.save();
        await underGoing.items.save();
      });

      return state.value!.copyWith(list);
    });
  }

  Future<List<KanbanItem>> getToday() async {
    var now = DateTime.now();
    var startOfDay = DateTime(now.year, now.month, now.day);
    var endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final l = await database.isar!.kanbanItems
        .filter()
        .createAtBetween(
            startOfDay.millisecondsSinceEpoch, endOfDay.millisecondsSinceEpoch)
        .findAll();

    // Map<String, List<KanbanItem>> m = {"data": l};

    return l;
  }

  bool _deadline(int time) {
    var now = DateTime.now();
    var endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return endOfDay.millisecondsSinceEpoch > time;
  }

  Future<int> newItem(KanbanData kanbanData, String itemTitle,
      {int? id}) async {
    state = const AsyncValue.loading();
    KanbanItem item = KanbanItem()
      ..title = itemTitle
      ..id = id;
    item.status = ItemStatus.inProgress;

    state = await AsyncValue.guard(() async {
      await database.isar!.writeTxn(() async {
        await database.isar!.kanbanItems.put(item);
        kanbanData.items.add(item);
        await kanbanData.items.save();
      });

      final list = await database.isar!.kanbanDatas.where().findAll();
      return BoardNotifierState(kanbanData: list);
    });

    return item.id!;
  }

  KanbanData? getDataByIndex(int index) {
    if (state.value == null) {
      return null;
    }
    return state.value!.kanbanData
        .where((element) => element.id == index)
        .first;
  }

  changeItemStatus(KanbanItem kanbanItem, {DateTime? deadline}) async {
    if (deadline == null) {
      return;
    }

    state = const AsyncValue.loading();
    final list = state.value!.kanbanData;

    state = await AsyncValue.guard(() async {
      final underGoing =
          list.where((element) => element.name == "In progress").first;

      if (kanbanItem.status == ItemStatus.pending) {
        final pending =
            list.where((element) => element.name == "Pending").first;
        if (deadline.millisecondsSinceEpoch > kanbanItem.deadline &&
            deadline.millisecondsSinceEpoch >
                DateTime.now().millisecondsSinceEpoch) {
          kanbanItem.status = ItemStatus.inProgress;
          underGoing.items.add(kanbanItem);
          pending.items.remove(kanbanItem);
        }

        await database.isar!.writeTxn(() async {
          await underGoing.items.save();
          await pending.items.save();
        });
      } else if (kanbanItem.status == ItemStatus.blocked) {
        final blocked =
            list.where((element) => element.name == "Blocked").first;
        if (deadline.millisecondsSinceEpoch > kanbanItem.deadline &&
            deadline.millisecondsSinceEpoch >
                DateTime.now().millisecondsSinceEpoch) {
          kanbanItem.status = ItemStatus.inProgress;
          underGoing.items.add(kanbanItem);
          blocked.items.remove(kanbanItem);
        }

        await database.isar!.writeTxn(() async {
          await underGoing.items.save();
          await blocked.items.save();
        });
      }

      kanbanItem.deadline = deadline.millisecondsSinceEpoch;

      await database.isar!.writeTxn(() async {
        await database.isar!.kanbanItems.put(kanbanItem);
      });

      return state.value!.copyWith(list);
    });
  }

  changeItemItemStatus(KanbanItem item, ItemStatus after) async {
    state = const AsyncValue.loading();

    final list = state.value!.kanbanData;

    state = await AsyncValue.guard(() async {
      final KanbanData beforeList, afterList;
      switch (item.status) {
        case ItemStatus.blocked:
          beforeList = list.where((element) => element.name == "Blocked").first;
          break;
        case ItemStatus.pending:
          beforeList = list.where((element) => element.name == "Pending").first;
          break;
        case ItemStatus.inProgress:
          beforeList =
              list.where((element) => element.name == "In progress").first;
          break;
        case ItemStatus.done:
          beforeList = list.where((element) => element.name == "Done").first;
          break;
      }
      switch (after) {
        case ItemStatus.blocked:
          afterList = list.where((element) => element.name == "Blocked").first;
          break;
        case ItemStatus.pending:
          afterList = list.where((element) => element.name == "Pending").first;
          break;
        case ItemStatus.inProgress:
          afterList =
              list.where((element) => element.name == "In progress").first;
          break;
        case ItemStatus.done:
          afterList = list.where((element) => element.name == "Done").first;
          break;
      }

      beforeList.items.remove(item);
      afterList.items.add(item);

      await database.isar!.writeTxn(() async {
        await beforeList.items.save();
        await afterList.items.save();
      });

      item.status = after;

      await database.isar!.writeTxn(() async {
        await database.isar!.kanbanItems.put(item);
      });
      return state.value!.copyWith(list);
    });
  }

  kanbanListReorder(KanbanData kanbanData, List<KanbanItem> items) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await database.isar!.writeTxn(() async {
        // if (oldIndex < newIndex) {
        //   newIndex -= 1;
        // }

        // final list = kanbanData.items.toList();
        // final item = list.removeAt(oldIndex);
        // list.insert(newIndex, item);
        // int index = 0;
        // for (final i in list) {
        //   i.orderNum = index;
        //   index += 1;
        // }
        await database.isar!.kanbanItems.putAll(items);

        await kanbanData.items.save();
      });

      final list = await database.isar!.kanbanDatas.where().findAll();

      return BoardNotifierState(kanbanData: list);
    });
  }

  moveItemTo(KanbanData kanbanData, KanbanItem item) async {
    state = const AsyncLoading();

    final list = state.value!.kanbanData;

    state = await AsyncValue.guard(() async {
      final KanbanData before;

      switch (item.status) {
        case ItemStatus.blocked:
          before = list.where((element) => element.name == "Blocked").first;
          break;
        case ItemStatus.pending:
          before = list.where((element) => element.name == "Pending").first;
          break;
        case ItemStatus.inProgress:
          before = list.where((element) => element.name == "In progress").first;
          break;
        case ItemStatus.done:
          before = list.where((element) => element.name == "Done").first;
          break;
      }

      before.items.remove(item);
      kanbanData.items.add(item);

      await database.isar!.writeTxn(() async {
        await before.items.save();
        await kanbanData.items.save();
        item.status = kanbanData.getStatus();
        await database.isar!.kanbanItems.put(item);
      });
      return BoardNotifierState(kanbanData: list);
    });
  }

  kanbanReorder(List<String> titles) async {
    // state = const AsyncLoading();

    await database.isar!.writeTxn(() async {
      int index = 0;
      for (final i in titles) {
        var data =
            state.value!.kanbanData.where((element) => element.name == i).first;
        data.orderNum = index;
        index += 1;
        await database.isar!.kanbanDatas.put(data);
      }
    });
    // state = AsyncValue.data(
    //     BoardNotifierState(kanbanData: state.value!.kanbanData));
  }

  Future<int> addNewItemPreview(String title) async {
    state = const AsyncLoading();
    final list = state.value!.kanbanData;
    KanbanItem kanbanItem = KanbanItem();
    state = await AsyncValue.guard(() async {
      final KanbanData before =
          list.where((element) => element.name == title).first;

      await database.isar!.writeTxn(() async {
        await database.isar!.kanbanItems.put(kanbanItem);
        before.items.add(kanbanItem);
        await before.items.save();
      });

      return state.value!.copyWith(list);
    });
    return kanbanItem.id!;
  }

  @Deprecated("")
  removeNewItemPreview(String title, int id) async {
    state = const AsyncLoading();
    final list = state.value!.kanbanData;
    state = await AsyncValue.guard(() async {
      final KanbanData before =
          list.where((element) => element.name == title).first;
      before.items.removeWhere((element) => element.id == id);

      await database.isar!.writeTxn(() async {
        await before.items.save();
        await database.isar!.kanbanItems.delete(id);
      });
      return state.value!.copyWith(list);
    });
  }
}

class InsertNewListItem extends KanbanItem {
  final bool isNew = true;
}

final kanbanBoardNotifier =
    AsyncNotifierProvider<BoardNotifier, BoardNotifierState>(() {
  return BoardNotifier();
});
