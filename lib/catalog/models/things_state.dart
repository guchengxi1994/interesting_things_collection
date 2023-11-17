import 'package:weaving/isar/thing.dart';

class ThingsState {
  final int catalogId;
  final List<Thing> thingsList;
  final int pageId;

  ThingsState({
    this.catalogId = 0,
    this.thingsList = const [],
    this.pageId = 0,
  });

  ThingsState copyWith(List<Thing> thingsList, int catalogId, int pageId) {
    return ThingsState(
      catalogId: catalogId,
      thingsList: thingsList,
      pageId: pageId,
    );
  }
}
