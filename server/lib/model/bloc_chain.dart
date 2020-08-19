import 'package:server/config/sys_val.dart';
import 'package:server/model/bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bloc_chain.g.dart';

@JsonSerializable()
class BlocChain {

  @JsonKey(name: 'chain')
  List _chain;

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

  // From generated file
  factory BlocChain.fromJson(Map<String, dynamic> json) => _$BlocChainFromJson(json);
  Map<String, dynamic> toJson() => _$BlocChainToJson(this);

}