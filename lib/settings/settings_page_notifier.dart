import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPageNotifier extends Notifier<(int, int)> {
  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  @override
  (int, int) build() {
    return (0, -1);
  }

  init() {
    state = (0, -1);
  }

  changePageIndex(int i) {
    state = (i, state.$2);
    _pageController.jumpToPage(i);
  }

  changeHoverIndex(int i) {
    state = (state.$1, i);
  }
}

final settingsPageController =
    NotifierProvider<SettingsPageNotifier, (int, int)>(
        () => SettingsPageNotifier());
