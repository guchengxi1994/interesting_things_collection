// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/isar/kanban.dart';
import 'package:weaving/schedule/notifiers/board_notifier.dart';
import 'package:weaving/schedule/notifiers/board_notifier_state.dart';

import 'board_v2_widget.dart';

class CustomBoardV2 extends ConsumerStatefulWidget {
  const CustomBoardV2({super.key});

  @override
  ConsumerState<CustomBoardV2> createState() => _CustomBoardV2State();
}

class _CustomBoardV2State extends ConsumerState<CustomBoardV2> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(kanbanBoardNotifier);

    return switch (state) {
      AsyncValue<BoardNotifierState>(:final value?) => Builder(builder: (c) {
          // ignore: no_leading_underscores_for_local_identifiers
          final List<KanbanData> _columns = value.kanbanData
            ..sort((a, b) => a.orderNum.compareTo(b.orderNum));

          return BoardV2Widget(
            kanbanData: _columns,
          );
        }),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}
