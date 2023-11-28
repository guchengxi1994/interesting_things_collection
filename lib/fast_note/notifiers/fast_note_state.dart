import 'package:weaving/isar/fast_note.dart';

class FastNoteState {
  List<FastNote> notes;
  FastNote? current;

  FastNoteState({this.notes = const [], this.current});

  FastNoteState copyWith({List<FastNote>? notes, FastNote? current}) {
    return FastNoteState(
        notes: notes ?? this.notes, current: current ?? this.current);
  }
}
