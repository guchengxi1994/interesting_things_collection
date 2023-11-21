import 'package:isar/isar.dart';
import 'package:weaving/isar/database.dart';
import 'package:weaving/isar/password.dart';
// ignore: implementation_imports
import 'package:dart_sm/src/sm4.dart';

class SMUtils {
  static const String _internalKey = '0123456789abcdeffedcba9876543210';
  // ignore: avoid_init_to_null
  String? _internalPassword = null;

  String get internalPassword => _internalPassword!;
  late IsarDatabase _isarDatabase;

  static final SMUtils _instance = SMUtils._internal();

  factory SMUtils() {
    return _instance;
  }

  SMUtils._internal() {
    if (_internalPassword == null) {
      Future.microtask(() async {
        await loadPassword();
      });
    }
  }

  loadPassword() async {
    _isarDatabase = IsarDatabase();

    final pwd =
        await _isarDatabase.isar!.passwords.where(sort: Sort.desc).findFirst();

    if (pwd != null) {
      _internalPassword = SM4.decrypt(pwd.password!, key: _internalKey);
    } else {
      _internalPassword = "";
    }
  }

  setPassword(String s) async {
    await _isarDatabase.isar!.writeTxn(() async {
      Password password = Password();
      password.password = SM4.encrypt(s, key: _internalKey);
      await _isarDatabase.isar!.passwords.put(password);
    });
    _internalPassword = s;
  }
}
