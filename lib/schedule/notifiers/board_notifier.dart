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
    return BoardNotifierState(kanbanData: list);
  }
}

final kanbanBoardNotifier =
    AsyncNotifierProvider<BoardNotifier, BoardNotifierState>(() {
  return BoardNotifier();
});
