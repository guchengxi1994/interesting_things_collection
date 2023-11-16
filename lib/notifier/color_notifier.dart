import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/common/local_storage.dart';

class ColorNotifier extends ChangeNotifier {
  late int currentColor = 0;
  final LocalStorage localStorage = LocalStorage();

  init() {
    currentColor = localStorage.getThemeColor();
    notifyListeners();
  }

  changeColor(int index) {
    if (currentColor != index) {
      currentColor = index;
      Future.microtask(
        () async {
          await localStorage.setThemeColor(currentColor);
        },
      );
      notifyListeners();
    }
  }
}

final colorNotifier = ChangeNotifierProvider((ref) => ColorNotifier());
