import 'dart:math';

const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
final Random _rnd = Random();
String getRandomString(int length) =>
    String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

// Random Id maker using a prefix
String getRandomID(String prefix, {int length = 10}) {
  return prefix + getRandomString(length);
}
