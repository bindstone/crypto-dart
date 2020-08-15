import 'package:server/config/sys_val.dart';
import 'package:server/model/bloc.dart';
import 'package:server/service/bloc_service.dart';
import 'package:test/test.dart';

void main() {
  var blocService = BlocService();
  
  test('Calculated Mine Bloc', () {
    var genesis = SysVal.GENESIS_BLOC;
    var minedBloc = blocService.mineBlock(genesis, 'New Data');

    expect(minedBloc.lastHash, genesis.hash);
    expect(minedBloc.data, 'New Data');
    expect(minedBloc.timestamp, isNotNull);

  });

  group('Bloc Validation',() {
    test('Valid Bloc', () {
      var bloc = Bloc(lastHash: '1337', timestamp: DateTime.now(), data: 'Test');
      bloc.hash = blocService.calculateHash(bloc);
      expect(blocService.valid(bloc), true);
    });

    test('Invalid Hash', () {
      var bloc = Bloc(lastHash: '1337', timestamp: DateTime.now(), data: 'Test');
      bloc.hash = 'INVALID';
      expect(blocService.valid(bloc), false);
    });

    test('invalid previous Hash', () {
      var bloc = Bloc(lastHash: '1337', timestamp: DateTime.now(), data: 'Test');
      bloc.hash = blocService.calculateHash(bloc);
      bloc.lastHash = '1007';
      expect(blocService.valid(bloc), false);
    });

    test('invalid Timestamp', () {
      var bloc = Bloc(lastHash: '1337', timestamp: DateTime.now(), data: 'Test');
      bloc.hash = blocService.calculateHash(bloc);
      bloc.timestamp = DateTime.now().add(Duration(days: 1));
      expect(blocService.valid(bloc), false);
    });

    test('invalid Data', () {
      var bloc = Bloc(lastHash: '1337', timestamp: DateTime.now(), data: 'Test');
      bloc.hash = blocService.calculateHash(bloc);
      bloc.data = 'INVALID';
      expect(blocService.valid(bloc), false);
    });
  });
}