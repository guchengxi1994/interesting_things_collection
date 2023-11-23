import 'package:weaving/isar/catalog_item.dart';

class CatalogItemsState {
  final int catalogId;
  final List<CatalogItem> list;
  final int pageId;

  CatalogItemsState({
    this.catalogId = 0,
    this.list = const [],
    this.pageId = 0,
  });

  CatalogItemsState copyWith(
      List<CatalogItem> itemsList, int catalogId, int pageId) {
    return CatalogItemsState(
      catalogId: catalogId,
      list: itemsList,
      pageId: pageId,
    );
  }
}
