import 'package:isar/isar.dart';

part 'fast_note.g.dart';

@collection
class FastNote {
  Id? id;
  String? key;
  List<String> values = [];
  int createAt = DateTime.now().millisecondsSinceEpoch;
}
