import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:weaving/common/local_storage.dart';
import 'package:weaving/common/sm_utils.dart';
import 'package:weaving/gen/strings.g.dart';
import 'package:weaving/isar/database.dart';
import 'package:weaving/isar/password.dart';
import 'package:weaving/notifier/settings_state.dart';
// ignore: implementation_imports
import 'package:dart_sm/src/sm4.dart';

class SettingsNotifier extends Notifier<SettingsState> {
  final LocalStorage localStorage = LocalStorage();
  late IsarDatabase isarDatabase = IsarDatabase();

  setPassword(String s) async {
    await isarDatabase.isar!.writeTxn(() async {
      Password password = Password();
      password.password = SM4.encrypt(s, key: SMUtils.internalKey);
      await isarDatabase.isar!.passwords.put(password);
    });

    await localStorage.setEnablePasscode(true);

    state = state.copyWith(enableUnlockPwd: true, password: s);
  }

  @override
  SettingsState build() {
    final showPreviewWhenHoverOnThings =
        localStorage.getShowPreviewWhenHoverOnThings();
    final currentLocale = localStorage.getCurrentLocale();
    final enablePwd = localStorage.getEnablePasscode();
    final password =
        isarDatabase.isar!.passwords.where(sort: Sort.desc).findFirstSync();

    return SettingsState(
        showPreviewWhenHoverOnThings: showPreviewWhenHoverOnThings,
        currentLocale: currentLocale,
        enableUnlockPwd: enablePwd,
        password: password == null ? "" : password.password ?? "");
  }

  changeShowPreviewWhenHoverOnThings(bool b) async {
    if (state.showPreviewWhenHoverOnThings != b) {
      state = state.copyWith(showPreviewWhenHoverOnThings: b);

      await localStorage.setShowPreviewWhenHoverOnThings(b);
    }
  }

  changeEnablePwd(bool b) async {
    if (state.enableUnlockPwd != b) {
      state = state.copyWith(enableUnlockPwd: b);
      await localStorage.setEnablePasscode(b);
    }
  }

  changeCurrentLocale(String locale) async {
    if (state.currentLocale != locale) {
      state = state.copyWith(currentLocale: locale);
      LocaleSettings.setLocaleRaw(locale);
      await localStorage.setCurrentLocale(locale);
    }
  }
}

final settingsNotifier =
    NotifierProvider<SettingsNotifier, SettingsState>(() => SettingsNotifier());
