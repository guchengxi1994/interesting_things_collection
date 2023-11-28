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
    final _ = ref.watch(fastNoteNotifier);

    if (note == null) {
      return Center(
        child: SizedBox(
          width: 250,
          height: 250,
          child: Image.asset("assets/empty.png"),
        ),
      );
    }

    print("note : ${note.key}");

    return Column(
      key: UniqueKey(),
      children: [_buildTitle(note, ref), _buildValues(note, ref)],
    );
  }

  Widget _buildTitle(FastNote note, WidgetRef ref) {
    print(note.key);
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

              ref
                  .read(fastNoteNotifier.notifier)
                  .updateNote(note)
                  .then((value) {
                ref
                    .read(fastNoteSelectionNotifier.notifier)
                    .changeCurrent(note);
              });
            },
          ),
          const Expanded(child: SizedBox()),
          InkWell(
            onTap: () {
              // note.values.add(FastNoteValue()..value = "请输入");
              ref
                  .read(fastNoteNotifier.notifier)
                  .updateNote(note, value: FastNoteValue()..value = "请输入");
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
    print("==========================");
    print(note.key);
    print(note.values.length);
    final objects = note.values.toList();
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
                  isEditing: i == 0 && objects[i].value == "请输入",
                  value: objects[i],
                  onDelete: (v) {
                    // List<String> l = List.from(note.values);
                    // l.removeAt(i);
                    note.values.retainWhere((element) => element.id != v.id);

                    ref.read(fastNoteNotifier.notifier).updateNote(note);
                  },
                  onSave: (s) {
                    // dont need to refresh
                    // note.values.add(FastNoteValue()..value = s);
                    ref
                        .read(fastNoteNotifier.notifier)
                        .updateNote(note, value: s);
                  },
                  onAdd: (s) {},
                  onChangeLockStatus: (v) {
                    ref
                        .read(fastNoteNotifier.notifier)
                        .updateNote(note, value: v);
                  },
                ),
              ),
          separatorBuilder: (c, i) => Divider(
                color: AppStyle.titleTextColor.withOpacity(0.5),
              ),
          itemCount: note.values.length),
    );
  }
}
