import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/config/mongo_config.dart';
import 'package:server/config/sys_val.dart';
import 'package:server/model/bloc.dart';
import 'package:server/model/bloc_chain.dart';
import 'package:server/service/bloc_service.dart';

class BocChainService {

  final Db _mongo;
  BlocService _blocService;

  BocChainService(this._mongo) {
    _blocService = BlocService(_mongo);
  }

  Future<BlocChain> getBlocChain() async {
    var col = _mongo.collection(COLLECTION_BLOC_CHAIN);
    var result = await col.findOne();
    if(result == null || result.isEmpty) {
      var blocChain = BlocChain();
      save(blocChain);
      return blocChain;
    } else {
      return BlocChain.fromJson(result);
    }
  }

  void save(BlocChain blocChain) async {
    await _mongo.collection(COLLECTION_BLOC_CHAIN).save(
      blocChain.toJson()
    );
  }

  Bloc addData(BlocChain blocChain, String data) {
    var bloc = _blocService.mineBlock(
        blocChain.chain().last, calculateAdjustment(blocChain), data);
    blocChain.addBloc(bloc);
    return bloc;
  }

  int calculateAdjustment(BlocChain blocChain) {
    if (blocChain.length() < 3) {
      return 0;
    }

    var blocPrev = blocChain.chain()[blocChain.length() - 1];
    var blocPrev2 = blocChain.chain()[blocChain.length() - 2];

    if (blocPrev.timestamp.difference(blocPrev2.timestamp).inMinutes >
        SysVal.MINER_TIME_ADJ_LONG) {
      return -1;
    } else if (blocPrev.timestamp.difference(blocPrev2.timestamp).inMinutes <
        SysVal.MINER_TIME_ADJ_SHORT) {
      return 1;
    } else {
      return 0;
    }
  }

  bool valid(BlocChain blocChain) {
    return validNotEmpty(blocChain) &&
        validGenesisBloc(blocChain) &&
        validChainOrder(blocChain) &&
        validDifficulty(blocChain) &&
        validBlocs(blocChain);
  }

  bool validNotEmpty(BlocChain blocChain) {
    return blocChain != null && blocChain.chain().isNotEmpty;
  }

  bool validGenesisBloc(BlocChain blocChain) {
    if (blocChain.chain()[0] != SysVal.GENESIS_BLOC) {
      return false;
    }
    return true;
  }

  bool validChainOrder(BlocChain blocChain) {
    var isValid = true;
    var p = blocChain.chain()[0];

    for (var e in blocChain.chain()) {
      isValid = isValid && p.hash == e.lastHash;
      p = e;
    }
    return isValid;
  }

  bool validBlocs(BlocChain blocChain) {
    return blocChain
        .chain()
        .sublist(1)
        .fold(true, (p, e) => p && _blocService.valid(e));
  }

  bool validToReplace(BlocChain curChain, BlocChain newChain) {
    if (curChain.length() >= newChain.length()) {
      return false;
    }
    return (valid(newChain));
  }

  bool validDifficulty(BlocChain blocChain) {
    var isValid = true;
    for (var i = 1; i < blocChain.length(); i++) {
      var chain = BlocChain(chain: blocChain.chain().sublist(0, i));
      var adj = calculateAdjustment(chain);
      isValid = isValid &&
          adj ==
              blocChain.chain()[i - 1].difficulty -
                  blocChain.chain()[i - 1].difficulty;
    }
    return isValid;
  }
}
