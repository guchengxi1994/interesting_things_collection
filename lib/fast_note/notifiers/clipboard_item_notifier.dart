import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClipboardItemState {
  List<String> list;

  ClipboardItemState({this.list = const []});

  ClipboardItemState copyWith({List<String>? list}) {
    return ClipboardItemState(list: list ?? this.list);
  }
}

class ClipboardItemNotifier extends Notifier<ClipboardItemState> {
  @override
  ClipboardItemState build() {
    return ClipboardItemState(list: []);
  }

  refresh(List<String> list) async {
    state = state.copyWith(list: list);
  }
}

final clipboardNotifier =
    NotifierProvider<ClipboardItemNotifier, ClipboardItemState>(() {
  return ClipboardItemNotifier();
});
