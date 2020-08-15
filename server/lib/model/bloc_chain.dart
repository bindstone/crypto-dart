import 'package:server/config/sys_val.dart';
import 'package:server/model/bloc.dart';

class BlocChain {
  var _chain = [];

  BlocChain() {
    _chain.add(SysVal.GENESIS_BLOC);
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