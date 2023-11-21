import 'package:isar/isar.dart';
import 'package:weaving/common/sm_utils.dart';

part 'pin_code.g.dart';

@collection
class PinCode {
  Id? id;
  String? pin;

  random() {
    pin = SMUtils.generateRandomString(length: 4, numberOnly: true);
  }
}
