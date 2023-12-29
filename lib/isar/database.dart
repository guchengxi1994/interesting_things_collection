import 'package:weaving/common/color_utils.dart';
import 'package:weaving/isar/catalog.dart';
import 'package:weaving/isar/fast_note.dart';
import 'package:weaving/isar/kanban.dart';
import 'package:weaving/isar/password.dart';
import 'package:weaving/isar/catalog_item.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weaving/settings/notifiers/database_state.dart'
    show TableDetails;
import 'package:weaving/style/app_style.dart';

class IsarDatabase {
  // ignore: avoid_init_to_null
  late Isar? isar = null;

  static final _instance = IsarDatabase._init();

  factory IsarDatabase() => _instance;

  IsarDatabase._init();

  late List<CollectionSchema<Object>> schemas = [
    CatalogSchema,
    CatalogItemSchema,
    PasswordSchema,
    FastNoteSchema,
    FastNoteValueSchema,
    KanbanDataSchema,
    KanbanItemSchema,
    KanbanItamTagSchema
  ];

  List<TableDetails> getAllDetails() {
    List<TableDetails> l = [];
    for (final i in schemas) {
      l.add(_getSchemaDetail(i));
    }
    return l;
  }

  TableDetails _getSchemaDetail(CollectionSchema sche) {
    switch (sche) {
      case CatalogSchema:
        final size = isar!.catalogs.getSizeSync();
        final count = isar!.catalogs.countSync();
        return TableDetails(size: size, rows: count, tableName: sche.name);
      case CatalogItemSchema:
        final size = isar!.catalogItems.getSizeSync();
        final count = isar!.catalogItems.countSync();
        return TableDetails(size: size, rows: count, tableName: sche.name);
      case PasswordSchema:
        final size = isar!.passwords.getSizeSync();
        final count = isar!.passwords.countSync();
        return TableDetails(size: size, rows: count, tableName: sche.name);
      case FastNoteSchema:
        final size = isar!.fastNotes.getSizeSync();
        final count = isar!.fastNotes.countSync();
        return TableDetails(size: size, rows: count, tableName: sche.name);
      case FastNoteValueSchema:
        final size = isar!.fastNoteValues.getSizeSync();
        final count = isar!.fastNoteValues.countSync();
        return TableDetails(size: size, rows: count, tableName: sche.name);
      case KanbanDataSchema:
        final size = isar!.kanbanDatas.getSizeSync();
        final count = isar!.kanbanDatas.countSync();
        return TableDetails(size: size, rows: count, tableName: sche.name);
      case KanbanItemSchema:
        final size = isar!.kanbanItems.getSizeSync();
        final count = isar!.kanbanItems.countSync();
        return TableDetails(size: size, rows: count, tableName: sche.name);
      case KanbanItamTagSchema:
        final size = isar!.kanbanItamTags.getSizeSync();
        final count = isar!.kanbanItamTags.countSync();
        return TableDetails(size: size, rows: count, tableName: sche.name);

      default:
        final size = isar!.catalogs.getSizeSync();
        final count = isar!.catalogs.countSync();
        return TableDetails(size: size, rows: count, tableName: sche.name);
    }
  }

  int get schemaCount => schemas.length;

  Future initialDatabase() async {
    if (isar != null && isar!.isOpen) {
      return;
    }
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      schemas,
      name: "weaving_db",
      directory: dir.path,
    );
    await initKanban();
  }

  initKanban() async {
    if (isar!.kanbanDatas.countSync() != 0) {
      return;
    }
    KanbanData blocked = KanbanData()
      ..color = ColorUtil.toHex(AppStyle.blockedColor)
      ..orderNum = 1
      ..name = "Blocked";
    KanbanData pending = KanbanData()
      ..color = ColorUtil.toHex(AppStyle.pendingColor)
      ..orderNum = 2
      ..name = "Pending";
    KanbanData inProgress = KanbanData()
      ..color = ColorUtil.toHex(AppStyle.inProgressColor)
      ..orderNum = 3
      ..name = "In progress";
    KanbanData done = KanbanData()
      ..color = ColorUtil.toHex(AppStyle.doneColor)
      ..orderNum = 4
      ..name = "Done";

    await isar!.writeTxn(() async {
      await isar!.kanbanDatas.putAll([blocked, pending, inProgress, done]);
    });
  }
}
