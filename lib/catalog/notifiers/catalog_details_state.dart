class CatalogDetailsState {
  final String catalogName;
  final List<String> tags;
  final double rating;

  CatalogDetailsState(
      {this.catalogName = "", this.rating = 0, this.tags = const []});
}
