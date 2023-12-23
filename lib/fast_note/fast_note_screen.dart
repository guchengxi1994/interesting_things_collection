import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/fast_note/components/side_menu.dart';
import 'package:weaving/fast_note/notifiers/fast_note_notifier.dart';
import 'package:weaving/isar/fast_note.dart';
import 'package:weaving/style/app_style.dart';

import 'components/export_fastnote_dialog.dart';
import 'components/fast_note_details.dart';

class FastNoteScreen extends ConsumerStatefulWidget {
  const FastNoteScreen({super.key});

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
            color: Colors.transparent, borderRadius: AppStyle.leftTopRadius),
        child: const Row(
          children: [
            SideMenu(),
            SizedBox(
              width: 1.5,
              child: VerticalDivider(
                width: 1.5,
                color: Color.fromARGB(255, 236, 243, 236),
              ),
            ),
            Expanded(
              child: FastNoteDetailsWidget(),
            )
          ],
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
                  .add(FastNote()..key = "新的笔记")
                  .then((value) {
                ref.read(fastNoteNotifier.notifier).changeCurrent(value);
              });
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.small(
            tooltip: "导出本周笔记",
            heroTag: null,
            child: const Icon(Icons.exposure),
            onPressed: () {
              ref
                  .read(fastNoteNotifier.notifier)
                  .getCurrentWeekNotes()
                  .then((value) {
                showGeneralDialog(
                    context: context,
                    pageBuilder: (c, _, __) {
                      return Center(
                        child: ExportFastnoteDialog(
                          notes: value,
                        ),
                      );
                    });
              });
            },
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
