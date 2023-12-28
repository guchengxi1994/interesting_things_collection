class DatabaseState {
  final List<TableDetails> details;
  final int size;
  final int databaseCount;

  DatabaseState(
      {required this.details, required this.size, required this.databaseCount});

  DatabaseState copyWith(
      {List<TableDetails>? details, int? size, int? databaseCount}) {
    return DatabaseState(
        details: details ?? this.details,
        size: size ?? this.size,
        databaseCount: databaseCount ?? this.databaseCount);
  }
}

class TableDetails {
  String tableName;
  int rows;
  int size;

  TableDetails(
      {required this.rows, required this.size, required this.tableName});
}
