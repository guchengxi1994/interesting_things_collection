import 'dart:math';

class SMUtils {
  static const String internalKey = '0123456789abcdeffedcba9876543210';
  // ignore: avoid_init_to_null

  static final SMUtils _instance = SMUtils._internal();

  factory SMUtils() {
    return _instance;
  }

  SMUtils._internal();

  static const _randomChars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  static const _numChars = "0123456789";

  static final Random _rnd = Random();

  static String generateRandomString(
      {int length = 32, bool numberOnly = false}) {
    if (numberOnly) {
      return String.fromCharCodes(Iterable.generate(length,
          (_) => _randomChars.codeUnitAt(_rnd.nextInt(_numChars.length))));
    }

    return String.fromCharCodes(Iterable.generate(length,
        (_) => _randomChars.codeUnitAt(_rnd.nextInt(_randomChars.length))));
  }
}
