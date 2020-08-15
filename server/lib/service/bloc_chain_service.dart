import 'package:server/config/sys_val.dart';
import 'package:server/model/bloc_chain.dart';
import 'package:server/service/bloc_service.dart';

class BocChainService {
  var blocService = BlocService();

  bool valid(BlocChain blocChain) {
    return validNotEmpty(blocChain) &&
           validGenesisBloc(blocChain) &&
           validChainOrder(blocChain) &&
           validBlocs(blocChain) ;
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
    return blocChain.chain().sublist(1).fold(true, (p, e) => p && blocService.valid(e));
  }
}