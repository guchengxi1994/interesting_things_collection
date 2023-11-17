import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/isar/database.dart';
import 'package:weaving/isar/thing.dart';

class ThingsHoverNotifier extends Notifier<int> {
  final IsarDatabase _database = IsarDatabase();

  @override
  build() {
    return 0;
  }

  changeIndex(int id) {
    if (state != id) {
      state = id;
    }
  }

  /// TODO
  ///
  /// move to other notifier
  Future saveThing(Thing thing) async {
    await _database.isar!.writeTxn(() async {
      await _database.isar!.things.put(thing);
    });
  }
}

final thingsHoverNotifier = NotifierProvider<ThingsHoverNotifier, int>(() {
  return ThingsHoverNotifier();
});
