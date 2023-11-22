import 'package:weaving/common/sm_utils.dart';
import 'package:weaving/isar/catalog.dart';
import 'package:weaving/isar/fast_note.dart';
import 'package:weaving/isar/password.dart';
import 'package:weaving/isar/thing.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase {
  // ignore: avoid_init_to_null
  late Isar? isar = null;

  static final _instance = IsarDatabase._init();

  factory IsarDatabase() => _instance;

  IsarDatabase._init() {
    _initialDatabase();
  }

  _initialDatabase() async {
    if (isar != null && isar!.isOpen) {
      return;
    }
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [CatalogSchema, ThingSchema, PasswordSchema, FastNoteSchema],
      name: "weaving_db",
      directory: dir.path,
    );
    // ignore: non_constant_identifier_names
    final SMUtils __ = SMUtils();
  }
}
