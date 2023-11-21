class SettingsState {
  final bool showPreviewWhenHoverOnThings;
  final String currentLocale;
  final List<String> supportLocales;
  final bool enableUnlockPwd;

  SettingsState(
      {this.showPreviewWhenHoverOnThings = true,
      this.enableUnlockPwd = false,
      this.currentLocale = "zh-CN",
      this.supportLocales = const ["zh-CN", "en"]});
}
