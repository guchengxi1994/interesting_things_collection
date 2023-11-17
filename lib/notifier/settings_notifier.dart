import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/common/local_storage.dart';
import 'package:weaving/gen/strings.g.dart';
import 'package:weaving/notifier/settings_state.dart';

class SettingsNotifier extends Notifier<SettingsState> {
  final LocalStorage localStorage = LocalStorage();

  @override
  SettingsState build() {
    final showPreviewWhenHoverOnThings =
        localStorage.getShowPreviewWhenHoverOnThings();
    final currentLocale = localStorage.getCurrentLocale();

    return SettingsState(
        showPreviewWhenHoverOnThings: showPreviewWhenHoverOnThings,
        currentLocale: currentLocale);
  }

  changeShowPreviewWhenHoverOnThings(bool b) async {
    if (state.showPreviewWhenHoverOnThings != b) {
      state = SettingsState(
          showPreviewWhenHoverOnThings: b, currentLocale: state.currentLocale);

      await localStorage.setShowPreviewWhenHoverOnThings(b);
    }
  }

  changeCurrentLocale(String locale) async {
    if (state.currentLocale != locale) {
      state = SettingsState(
          showPreviewWhenHoverOnThings: state.showPreviewWhenHoverOnThings,
          currentLocale: locale);
      LocaleSettings.setLocaleRaw(locale);
      await localStorage.setCurrentLocale(locale);
    }
  }
}

final settingsNotifier =
    NotifierProvider<SettingsNotifier, SettingsState>(() => SettingsNotifier());
