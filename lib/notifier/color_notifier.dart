import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/common/local_storage.dart';

class ColorNotifier extends Notifier<int> {
  final LocalStorage localStorage = LocalStorage();

  changeColor(int index) {
    if (state != index) {
      state = index;
      Future.microtask(
        () async {
          await localStorage.setThemeColor(state);
        },
      );
    }
  }

  @override
  int build() {
    state = localStorage.getThemeColor();
    return state;
  }
}

final colorNotifier =
    NotifierProvider<ColorNotifier, int>(() => ColorNotifier());
