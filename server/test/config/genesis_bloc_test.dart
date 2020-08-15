import 'package:server/config/sys_val.dart';
import 'package:server/model/bloc_chain.dart';
import 'package:test/test.dart';

void main() {
  var genesis = SysVal.GENESIS_BLOC;
  test('Test Genesis Bloc', () {

    expect(genesis.hash, '1337');
    expect(genesis.lastHash, '1337');
    expect(genesis.data, '');
    expect(genesis.timestamp, DateTime(2000, 1, 1, 13, 37, 0, 0, 0));

  });
}
