import 'package:weaving/isar/kanban.dart';

class BoardNotifierState {
  List<KanbanData> kanbanData;

  BoardNotifierState({this.kanbanData = const []});

  BoardNotifierState copyWith(List<KanbanData>? kanbanData) {
    return BoardNotifierState(kanbanData: kanbanData ?? this.kanbanData);
  }
}
