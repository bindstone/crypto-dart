import 'dart:convert';

import 'package:server/model/bloc.dart';
import 'package:crypto/crypto.dart';

class BlocService {

  Bloc mineBlock(Bloc previous, String data) {
    var bloc =  Bloc();
    bloc.lastHash = previous.hash;
    bloc.data = data;
    bloc.timestamp = DateTime.now();
    
    bloc.hash = calculateHash(bloc);
    
    return bloc;
  }

  String calculateHash(Bloc bloc) {
    var check = '${bloc.lastHash} ${bloc.timestamp} ${bloc.data}';
    return sha256.convert(check.codeUnits).toString();
  }

  bool valid(Bloc bloc) {
    return calculateHash(bloc) == bloc.hash;
  }

}
