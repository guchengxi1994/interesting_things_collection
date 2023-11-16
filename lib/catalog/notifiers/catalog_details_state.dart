class CatalogDetailsState {
  final String catalogName;
  final List<String> tags;
  final double rating;
  final int createAt;

  CatalogDetailsState(
      {this.catalogName = "",
      this.rating = 0,
      this.tags = const [],
      this.createAt = 0});
}
