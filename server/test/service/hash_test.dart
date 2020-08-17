import 'package:test/test.dart';
import 'package:crypto/crypto.dart';

void main() {

  test('Test Hash', () {
    var bytes = 'message'.codeUnits;
    var hash = sha256.convert(bytes).toString();
    assert(hash == 'ab530a13e45914982b79f9b7e3fba994cfd1f3fb22f71cea1afbf02b460c6d1d');  // true
    print(hash);
    hash.split('').forEach((x) => print(int.parse(x, radix: 16).toRadixString(2).padLeft(8, '0')));
  });

}