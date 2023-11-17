class SettingsState {
  final bool showPreviewWhenHoverOnThings;
  final String currentLocale;
  final List<String> supportLocales;

  SettingsState(
      {this.showPreviewWhenHoverOnThings = true,
      this.currentLocale = "zh-CN",
      this.supportLocales = const ["zh-CN", "en"]});
}
