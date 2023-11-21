import 'package:isar/isar.dart';
import 'package:weaving/isar/password.dart';
// ignore: implementation_imports
import 'package:dart_sm/src/sm4.dart';

part 'fast_note.g.dart';

@collection
class FastNote {
  Id? id;
  String? key;
  List<String> values = [];
  bool hiddenValues = false;
  int createAt = DateTime.now().millisecondsSinceEpoch;

  final password = IsarLink<Password>();

  autoEncrypt(String password) {
    if (values.isEmpty) {
      return;
    }
    values = values.map((e) => SM4.encrypt(e, key: password)).toList();
  }

  autoDecrypt() {
    if (values.isEmpty) {
      return;
    }
    values = values
        .map((e) => SM4.decrypt(e, key: password.value!.password!) as String)
        .toList();
  }
}
