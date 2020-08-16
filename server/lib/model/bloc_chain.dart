import 'package:server/config/sys_val.dart';
import 'package:server/model/bloc.dart';

class BlocChain {
  var _chain;

  BlocChain({List chain}) {
    if(chain == null) {
      _chain = [];
      _chain.add(SysVal.GENESIS_BLOC);
    } else {
      _chain = chain;
    }
  }

  int length() {
    return _chain.length;
  }

  void addBloc(Bloc bloc) {
    _chain.add(bloc);
  }

  List<Bloc> chain() {
    return List.unmodifiable(_chain);
  }

  void replaceChain(List<Bloc> newChain) {
    _chain = newChain;
  }

}