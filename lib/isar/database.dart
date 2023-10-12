import 'package:interesting_things_collection/isar/catalog.dart';
import 'package:interesting_things_collection/isar/thing.dart';
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
      [CatalogSchema, ThingSchema],
      name: "interesting_things",
      directory: dir.path,
    );
  }
}
