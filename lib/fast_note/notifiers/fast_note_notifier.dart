import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:weaving/isar/database.dart';
import 'package:weaving/isar/fast_note.dart';

import 'fast_note_state.dart';

class FastNoteNotifier extends AsyncNotifier<FastNoteState> {
  final IsarDatabase isarDatabase = IsarDatabase();

  @override
  FutureOr<FastNoteState> build() async {
    return FastNoteState(
        notes: await isarDatabase.isar!.fastNotes.where().findAll());
  }

  filter(String s) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return FastNoteState(
          notes: await isarDatabase.isar!.fastNotes
              .filter()
              .keyContains(s)
              .findAll());
    });
  }

  Future<FastNote> add(FastNote note) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await isarDatabase.isar!.writeTxn(() async {
        isarDatabase.isar!.fastNotes.put(note);
      });
      return FastNoteState(
          notes: await isarDatabase.isar!.fastNotes.where().findAll());
    });
    return note;
  }

  Future updateNote(FastNote note, {FastNoteValue? value}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await isarDatabase.isar!.writeTxn(() async {
        if (value != null) {
          await isarDatabase.isar!.fastNoteValues.put(value);
          note.values.add(value);
        } else {
          await isarDatabase.isar!.fastNotes.put(note);
        }
      });
      // print(note.values);
      final index =
          state.value!.notes.indexWhere((element) => element.id == note.id);

      state.value!.notes.removeAt(index);
      state.value!.notes.insert(index, note);

      return state.value!.copyWith(state.value!.notes);
    });
  }

  // Future saveNoteValue(String value) async {}

  Future onEncode() async {}
}

final fastNoteNotifier =
    AsyncNotifierProvider<FastNoteNotifier, FastNoteState>(() {
  return FastNoteNotifier();
});
