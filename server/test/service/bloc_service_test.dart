import 'package:server/config/sys_val.dart';
import 'package:server/model/bloc.dart';
import 'package:server/service/bloc_service.dart';
import 'package:test/test.dart';

void main() {
  var blocService = BlocService(null);
  
  test('Calculated Mine Bloc', () {
    var genesis = SysVal.GENESIS_BLOC;
    var minedBloc = blocService.mineBlock(genesis, 0, 'New Data');

    expect(minedBloc.lastHash, genesis.hash);
    expect(minedBloc.data, 'New Data');
    expect(minedBloc.timestamp, isNotNull);

  });

  group('Bloc Validation',() {
    var bloc;
    setUp(() {
      bloc = Bloc(lastHash: '1337', timestamp: DateTime.now(), data: 'Test');
      bloc.hash = blocService.calculateHash(bloc);
    });

    test('Valid Bloc', () {
      expect(blocService.valid(bloc), true);
    });

    test('Invalid Hash', () {
      bloc.hash = 'INVALID';
      expect(blocService.valid(bloc), false);
    });

    test('invalid previous Hash', () {
      bloc.lastHash = '1007';
      expect(blocService.valid(bloc), false);
    });

    test('invalid Timestamp', () {
      bloc.timestamp = DateTime.now().add(Duration(days: 1));
      expect(blocService.valid(bloc), false);
    });

    test('invalid Data', () {
      bloc.data = 'INVALID';
      expect(blocService.valid(bloc), false);
    });
  });
}