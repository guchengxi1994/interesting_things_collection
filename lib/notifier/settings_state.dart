class SettingsState {
  final bool showPreviewWhenHoverOnItems;
  final String currentLocale;
  final List<String> supportLocales;
  final bool enableUnlockPwd;
  final String password;

  SettingsState(
      {this.showPreviewWhenHoverOnItems = true,
      this.enableUnlockPwd = false,
      this.currentLocale = "zh-CN",
      this.supportLocales = const ["zh-CN", "en"],
      this.password = ""});

  SettingsState copyWith(
      {bool? showPreviewWhenHoverOnItems,
      String? currentLocale,
      List<String>? supportLocales,
      bool? enableUnlockPwd,
      String? password}) {
    return SettingsState(
        currentLocale: currentLocale ?? this.currentLocale,
        showPreviewWhenHoverOnItems:
            showPreviewWhenHoverOnItems ?? this.showPreviewWhenHoverOnItems,
        supportLocales: supportLocales ?? this.supportLocales,
        enableUnlockPwd: enableUnlockPwd ?? this.enableUnlockPwd,
        password: password ?? this.password);
  }
}
