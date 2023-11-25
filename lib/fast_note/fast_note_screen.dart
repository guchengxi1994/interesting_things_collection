import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/fast_note/components/side_menu.dart';
import 'package:weaving/fast_note/notifiers/fast_note_notifier.dart';
import 'package:weaving/isar/fast_note.dart';
import 'package:weaving/style/app_style.dart';

import 'components/fast_note_details.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(fastNoteNotifier.notifier).add(FastNote()
            ..key = "ad-test-2"
            ..values = [
              "ddd",
              "dddddddddddddddddddddddddddddddddddddddddddddddddddd",
              "d",
              "d1",
              "d2",
              "d3",
              "d4",
              "d5",
              "d6",
              "d7",
              "d8"
            ]);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
