import 'package:weaving/isar/fast_note.dart';

class FastNoteState {
  List<FastNote> notes;

  FastNoteState({this.notes = const []});

  FastNoteState copyWith(List<FastNote>? notes) {
    return FastNoteState(notes: notes ?? this.notes);
  }
}
