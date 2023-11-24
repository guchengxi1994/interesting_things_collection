import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/fast_note/components/side_menu.dart';
import 'package:weaving/fast_note/fast_note_notifier.dart';
import 'package:weaving/isar/fast_note.dart';

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
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
        child: const Row(
          children: [SideMenu(), Expanded(child: SizedBox())],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(fastNoteNotifier.notifier).add(FastNote()
            ..key = "ad"
            ..values = []);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
