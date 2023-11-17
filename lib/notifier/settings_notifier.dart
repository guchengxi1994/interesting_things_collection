import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/common/local_storage.dart';
import 'package:weaving/notifier/settings_state.dart';

class SettingsNotifier extends Notifier<SettingsState> {
  final LocalStorage localStorage = LocalStorage();

  @override
  SettingsState build() {
    final showPreviewWhenHoverOnThings =
        localStorage.getShowPreviewWhenHoverOnThings();

    return SettingsState(
        showPreviewWhenHoverOnThings: showPreviewWhenHoverOnThings);
  }

  changeShowPreviewWhenHoverOnThings(bool b) async {
    if (state.showPreviewWhenHoverOnThings != b) {
      state = SettingsState(showPreviewWhenHoverOnThings: b);

      await localStorage.setShowPreviewWhenHoverOnThings(b);
    }
  }
}

final settingsNotifier =
    NotifierProvider<SettingsNotifier, SettingsState>(() => SettingsNotifier());
