import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/fast_note/components/side_menu.dart';
import 'package:weaving/fast_note/notifiers/fast_note_notifier.dart';
import 'package:weaving/isar/fast_note.dart';
import 'package:weaving/style/app_style.dart';

import 'components/fast_note_details.dart';
import 'notifiers/fast_note_selection_notifier.dart';

class FastNoteScreen extends ConsumerStatefulWidget {
  const FastNoteScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FastNoteScreen> createState() => _FastNoteScreenState();
}

class _FastNoteScreenState extends ConsumerState<FastNoteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white, borderRadius: AppStyle.leftTopRadius),
        child: const Row(
          children: [SideMenu(), Expanded(child: FastNoteDetailsWidget())],
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        distance: 50,
        type: ExpandableFabType.side,
        children: [
          FloatingActionButton.small(
            tooltip: "创建新的笔记",
            heroTag: "new-fast-note",
            onPressed: () {
              ref
                  .read(fastNoteNotifier.notifier)
                  .add(FastNote()
                    ..key = "新的笔记"
                    ..values = [])
                  .then((value) {
                ref
                    .read(fastNoteSelectionNotifier.notifier)
                    .changeCurrent(value);
              });
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.small(
            tooltip: "导出本周笔记",
            heroTag: null,
            child: const Icon(Icons.exposure),
            onPressed: () {},
          ),
          FloatingActionButton.small(
            tooltip: "导出所有笔记",
            heroTag: null,
            child: const Icon(Icons.exposure_outlined),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
