class SettingsState {
  final bool showPreviewWhenHoverOnThings;
  final String currentLocale;
  final List<String> supportLocales;
  final bool enableUnlockPwd;
  final String password;

  SettingsState(
      {this.showPreviewWhenHoverOnThings = true,
      this.enableUnlockPwd = false,
      this.currentLocale = "zh-CN",
      this.supportLocales = const ["zh-CN", "en"],
      this.password = ""});

  SettingsState copyWith(
      {bool? showPreviewWhenHoverOnThings,
      String? currentLocale,
      List<String>? supportLocales,
      bool? enableUnlockPwd,
      String? password}) {
    return SettingsState(
        currentLocale: currentLocale ?? this.currentLocale,
        showPreviewWhenHoverOnThings:
            showPreviewWhenHoverOnThings ?? this.showPreviewWhenHoverOnThings,
        supportLocales: supportLocales ?? this.supportLocales,
        enableUnlockPwd: enableUnlockPwd ?? this.enableUnlockPwd,
        password: password ?? this.password);
  }
}
