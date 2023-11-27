import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:weaving/isar/database.dart';
import 'package:weaving/isar/fast_note.dart';

class FastNoteSelectionNotifier extends Notifier<FastNote?> {
  final IsarDatabase isarDatabase = IsarDatabase();

  @override
  FastNote? build() {
    return null;
  }

  changeCurrent(FastNote? note) {
    if (note == null) {
      state = null;
      return;
    }

    final nt = isarDatabase.isar!.fastNotes
        .where()
        .idEqualTo(note.id!)
        .findFirstSync();

    state = nt;
  }

  refreshNode(FastNote note) {
    state = state!.copyWith(id: note.id, key: note.key, values: note.values);
  }

  Future<List<FastNote>> getCurrentWeekNotes() async {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek =
        now.add(Duration(days: DateTime.daysPerWeek - now.weekday));

    startOfWeek =
        DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    endOfWeek = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day);

    List<FastNote> results = await isarDatabase.isar!.fastNotes
        .filter()
        .createAtBetween(startOfWeek.millisecondsSinceEpoch,
            endOfWeek.millisecondsSinceEpoch)
        .findAll();

    return results;
  }
}

final fastNoteSelectionNotifier =
    NotifierProvider<FastNoteSelectionNotifier, FastNote?>(() {
  return FastNoteSelectionNotifier();
});
