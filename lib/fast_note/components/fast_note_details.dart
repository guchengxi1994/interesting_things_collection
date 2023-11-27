import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/fast_note/notifiers/fast_note_notifier.dart';
import 'package:weaving/fast_note/notifiers/fast_note_selection_notifier.dart';
import 'package:weaving/isar/fast_note.dart';
import 'package:weaving/style/app_style.dart';

import 'custom_editable_text.dart';
import 'custom_editable_title.dart';

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
      key: UniqueKey(),
      children: [_buildTitle(note, ref), _buildValues(note, ref)],
    );
  }

  Widget _buildTitle(FastNote note, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 50,
      child: Row(
        children: [
          Text(
            "Id: ${note.id}    ",
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppStyle.titleTextColor),
          ),
          CustomEditableTitle(
            // key: UniqueKey(),
            title: note.key ?? "",
            onSave: (String s) {
              note.key = s;

              ref.read(fastNoteNotifier.notifier).updateNote(note);
              ref.read(fastNoteSelectionNotifier.notifier).refreshNode(note);
            },
          ),
          const Expanded(child: SizedBox()),
          InkWell(
            onTap: () {
              List<String> l = List.from(note.values);
              l.insert(0, "请输入");
              note.values = l;
              ref.read(fastNoteSelectionNotifier.notifier).refreshNode(note);
            },
            child: const Icon(
              Icons.add,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildValues(FastNote note, WidgetRef ref) {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppStyle.titleTextColor.withOpacity(.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.separated(
          // key: UniqueKey(),
          itemBuilder: (c, i) => Container(
                height: 50,
                padding: const EdgeInsets.all(5),
                child: CustomEditableText(
                  isEditing: i == 0 && note.values[i] == "请输入",
                  value: note.values[i],
                  onDelete: () {
                    List<String> l = List.from(note.values);
                    l.removeAt(i);
                    note.values = l;

                    ref.read(fastNoteNotifier.notifier).updateNote(note);
                    ref
                        .read(fastNoteSelectionNotifier.notifier)
                        .refreshNode(note);
                  },
                  onSave: (s) {
                    // dont need to refresh
                    note.values[i] = s;
                    ref.read(fastNoteNotifier.notifier).updateNote(note);
                  },
                  onAdd: (s) {},
                ),
              ),
          separatorBuilder: (c, i) => Divider(
                color: AppStyle.titleTextColor.withOpacity(0.5),
              ),
          itemCount: note.values.length),
    );
  }
}
