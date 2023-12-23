import 'package:weaving/common/color_utils.dart';
import 'package:weaving/isar/catalog.dart';
import 'package:weaving/isar/fast_note.dart';
import 'package:weaving/isar/kanban.dart';
import 'package:weaving/isar/password.dart';
import 'package:weaving/isar/catalog_item.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weaving/style/app_style.dart';

class IsarDatabase {
  // ignore: avoid_init_to_null
  late Isar? isar = null;

  static final _instance = IsarDatabase._init();

  factory IsarDatabase() => _instance;

  IsarDatabase._init();

  Future initialDatabase() async {
    if (isar != null && isar!.isOpen) {
      return;
    }
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        CatalogSchema,
        CatalogItemSchema,
        PasswordSchema,
        FastNoteSchema,
        FastNoteValueSchema,
        KanbanDataSchema,
        KanbanItemSchema,
        KanbanItamTagSchema
      ],
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
