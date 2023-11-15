import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThingsHoverNotifier extends Notifier<int> {
  @override
  build() {
    return 0;
  }

  changeIndex(int id) {
    if (state != id) {
      state = id;
    }
  }
}

final thingsHoverNotifier = NotifierProvider<ThingsHoverNotifier, int>(() {
  return ThingsHoverNotifier();
});
