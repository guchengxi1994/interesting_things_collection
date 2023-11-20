import 'package:isar/isar.dart';

part 'password.g.dart';

@collection
class Password {
  Id passwordId = Isar.autoIncrement;
  String? password;
}
