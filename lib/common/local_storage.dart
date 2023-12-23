import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final _instance = LocalStorage._init();

  factory LocalStorage() => _instance;

  static SharedPreferences? _storage;

  LocalStorage._init() {
    _initStorage();
  }

  _initStorage() async {
    _storage ??= await SharedPreferences.getInstance();
  }

  int getThemeColor() {
    return _storage!.getInt("themeColor") ?? 2;
  }

  Future setThemeColor(int c) async {
    await _storage!.setInt("themeColor", c);
  }

  bool getShowPreviewWhenHoverOnItems() {
    return _storage!.getBool("showPreviewWhenHoverOnItems") ?? true;
  }

  Future setShowPreviewWhenHoverOnItems(bool b) async {
    await _storage!.setBool("showPreviewWhenHoverOnItems", b);
  }

  String getCurrentLocale() {
    return _storage!.getString("currentLocale") ?? "zh-CN";
  }

  Future setCurrentLocale(String locale) async {
    await _storage!.setString("currentLocale", locale);
  }

  bool getEnablePasscode() {
    return _storage!.getBool("enablePasscode") ?? true;
  }

  Future setEnablePasscode(bool b) async {
    await _storage!.setBool("enablePasscode", b);
  }

  Future setBgImagePath(String s) async {
    await _storage!.setString("bgImage", s);
  }

  String? getBgImagePath() {
    return _storage!.getString("bgImage");
  }
}
