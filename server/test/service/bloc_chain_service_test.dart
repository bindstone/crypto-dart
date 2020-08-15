import 'package:server/config/sys_val.dart';
import 'package:server/model/bloc.dart';
import 'package:server/model/bloc_chain.dart';
import 'package:server/service/bloc_service.dart';
import 'package:server/service/bloc_chain_service.dart';
import 'package:test/test.dart';

void main() {
  var genesis = SysVal.GENESIS_BLOC;
  var blocChainService = BocChainService();

  group('New Chain',() {
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

  group('Valid Chain',() {

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

  group('Invalid Chains',() {

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
  });
}