import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/fast_note/notifiers/fast_note_notifier.dart';
import 'package:weaving/fast_note/notifiers/fast_note_selection_notifier.dart';
import 'package:weaving/isar/fast_note.dart';
import 'package:weaving/style/app_style.dart';

import 'custom_editable_text.dart';

class FastNoteDetailsWidget extends ConsumerWidget {
  const FastNoteDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final note = ref.watch(fastNoteSelectionNotifier);

    if (note == null) {
      return Center(
        child: SizedBox(
          width: 250,
          height: 250,
          child: Image.asset("assets/empty.png"),
        ),
      );
    }

    return Column(
      children: [_buildTitle(note), _buildValues(note, ref)],
    );
  }

  Widget _buildTitle(FastNote note) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 50,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          note.key ?? "",
          style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppStyle.titleTextColor),
        ),
      ),
    );
  }

  Widget _buildValues(FastNote note, WidgetRef ref) {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppStyle.titleTextColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.separated(
          key: UniqueKey(),
          itemBuilder: (c, i) => Container(
                height: 50,
                padding: const EdgeInsets.all(5),
                child: CustomEditableText(
                  value: note.values[i],
                  onDelete: () {
                    /// FIXME not refresh
                    List<String> l = List.from(note.values);
                    l.removeAt(i);
                    note.values = l;

                    ref.read(fastNoteNotifier.notifier).updateNote(note);
                    // ref
                    //     .read(fastNoteSelectionNotifier.notifier)
                    //     .refreshNode(note);
                  },
                  onSave: (s) {
                    // dont need to refresh
                    note.values[i] = s;
                    ref.read(fastNoteNotifier.notifier).updateNote(note);
                  },
                ),
              ),
          separatorBuilder: (c, i) => const Divider(
                color: AppStyle.titleTextColor,
              ),
          itemCount: note.values.length),
    );
  }
}
