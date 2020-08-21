import 'package:server/config/sys_val.dart';
import 'package:server/model/bloc.dart';
import 'package:server/model/bloc_chain.dart';
import 'package:server/service/bloc_service.dart';
import 'package:server/service/bloc_chain_service.dart';
import 'package:test/test.dart';

void main() {
  var genesis = SysVal.GENESIS_BLOC;
  var blocChainService = BocChainService(null);
  var blocService = BlocService(null);

  group('New Chain', () {
    test('valid Genesis', () {
      var chain = BlocChain();
      expect(blocChainService.valid(chain), true);
    });

    test('Empty Chain', () {
      var chain = BlocChain();
      chain.replaceChain([]);
      expect(blocChainService.validNotEmpty(chain), false);
    });

    test('Invalid Genesis', () {
      var errBloc = Bloc();
      errBloc.timestamp = genesis.timestamp;
      errBloc.data = genesis.data;
      errBloc.lastHash = genesis.lastHash;

      var chain = BlocChain();
      chain.replaceChain([errBloc]);
      expect(blocChainService.validGenesisBloc(chain), false);
    });
  });

  group('Valid Chain', () {
    test('Valid Chain', () {
      var bloc1 = Bloc();
      bloc1.timestamp = genesis.timestamp;
      bloc1.data = genesis.data;
      bloc1.lastHash = genesis.hash;
      bloc1.hash = 'bloc1';

      var bloc2 = Bloc();
      bloc2.timestamp = genesis.timestamp;
      bloc2.data = genesis.data;
      bloc2.lastHash = 'bloc1';
      bloc2.hash = 'bloc2';

      var chain = BlocChain();
      chain.replaceChain([genesis, bloc1, bloc2]);
      expect(blocChainService.validChainOrder(chain), true);
    });
  });

  group('Invalid Chains', () {
    test('Invalid Chain 1', () {
      var bloc1 = Bloc();
      bloc1.timestamp = genesis.timestamp;
      bloc1.data = genesis.data;
      bloc1.lastHash = genesis.hash;
      bloc1.hash = 'bloc1';

      var bloc2 = Bloc();
      bloc2.timestamp = genesis.timestamp;
      bloc2.data = genesis.data;
      bloc2.lastHash = genesis.hash;
      bloc2.hash = 'bloc2';

      var chain = BlocChain();
      chain.replaceChain([genesis, bloc1, bloc2]);
      expect(blocChainService.validChainOrder(chain), false);
    });

    test('Invalid Chain 2', () {
      var bloc1 = Bloc();
      bloc1.timestamp = genesis.timestamp;
      bloc1.data = genesis.data;
      bloc1.lastHash = 'invalid';
      bloc1.hash = 'bloc1';

      var bloc2 = Bloc();
      bloc2.timestamp = genesis.timestamp;
      bloc2.data = genesis.data;
      bloc2.lastHash = 'bloc1';
      bloc2.hash = 'bloc2';

      var chain = BlocChain();
      chain.replaceChain([genesis, bloc1, bloc2]);
      expect(blocChainService.validChainOrder(chain), false);
    });

    test('Invalid Difficulty', () {
      var bloc1 = Bloc();
      bloc1.timestamp = genesis.timestamp;
      bloc1.data = genesis.data;
      bloc1.lastHash = 'invalid';
      bloc1.difficulty = genesis.difficulty;
      bloc1.hash = 'bloc1';

      var bloc2 = Bloc();
      bloc2.timestamp = genesis.timestamp;
      bloc2.data = genesis.data;
      bloc2.lastHash = 'bloc2';
      bloc2.difficulty = genesis.difficulty;
      bloc2.hash = 'bloc2';

      var bloc3 = Bloc();
      bloc3.timestamp = genesis.timestamp;
      bloc3.data = genesis.data;
      bloc3.lastHash = 'bloc3';
      bloc3.difficulty = genesis.difficulty;
      bloc3.hash = 'bloc3';

      var chain = BlocChain();
      chain.replaceChain([genesis, bloc1, bloc2, bloc3]);
      expect(blocChainService.validDifficulty(chain), false);
    });

  });

  group('Replace Chain Validation', () {
    test('Valid Chain', () {
      var curChain = BlocChain();

      var newChain = BlocChain();
      var bloc = Bloc(lastHash: '1337', timestamp: DateTime.now(), data: 'Test');
      bloc.hash = blocService.calculateHash(bloc);
      newChain.addBloc(bloc);

      expect(blocChainService.validToReplace(curChain, newChain), true);
    });

    test('Invalid Chain', () {
      var curChain = BlocChain();
      var bloc = Bloc(lastHash: '1337', timestamp: DateTime.now(), data: 'Test');
      bloc.hash = blocService.calculateHash(bloc);
      curChain.addBloc(bloc);

      var newChain = BlocChain();
      expect(blocChainService.validToReplace(curChain, newChain), false);
    });
  });

  group('Test Adjustments', () {
    test('No Adjustment', () {

      var chain = BlocChain();
      var bloc1 = Bloc(lastHash: '1337', timestamp: DateTime.now(), data: 'Test');
      bloc1.hash = blocService.calculateHash(bloc1);
      chain.addBloc(bloc1);

      var bloc2 = Bloc(lastHash: '1337', timestamp: DateTime.now().add(Duration(minutes: 5)), data: 'Test');
      bloc2.hash = blocService.calculateHash(bloc1);
      chain.addBloc(bloc2);

      expect(blocChainService.calculateAdjustment(chain), 0);
    });

    test('next slower', () {

      var chain = BlocChain();
      var bloc1 = Bloc(lastHash: '1337', timestamp: DateTime.now(), data: 'Test');
      bloc1.hash = blocService.calculateHash(bloc1);
      chain.addBloc(bloc1);

      var bloc2 = Bloc(lastHash: '1337', timestamp: DateTime.now().add(Duration(minutes: 10)), data: 'Test');
      bloc2.hash = blocService.calculateHash(bloc1);
      chain.addBloc(bloc2);

      expect(blocChainService.calculateAdjustment(chain), -1);
    });

    test('next faster', () {

      var chain = BlocChain();
      var bloc1 = Bloc(lastHash: '1337', timestamp: DateTime.now(), data: 'Test');
      bloc1.hash = blocService.calculateHash(bloc1);
      chain.addBloc(bloc1);

      var bloc2 = Bloc(lastHash: '1337', timestamp: DateTime.now().add(Duration(minutes: 1)), data: 'Test');
      bloc2.hash = blocService.calculateHash(bloc1);
      chain.addBloc(bloc2);

      expect(blocChainService.calculateAdjustment(chain), 1);
    });
  });
}