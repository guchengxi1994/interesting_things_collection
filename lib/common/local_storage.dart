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

  bool getShowPreviewWhenHoverOnThings() {
    return _storage!.getBool("showPreviewWhenHoverOnThings") ?? true;
  }

  Future setShowPreviewWhenHoverOnThings(bool b) async {
    await _storage!.setBool("showPreviewWhenHoverOnThings", b);
  }
}
