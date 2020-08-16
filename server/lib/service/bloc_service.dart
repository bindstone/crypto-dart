import 'package:server/model/bloc.dart';
import 'package:crypto/crypto.dart';

class BlocService {

  Bloc mineBlock(Bloc previous, int adjusting, String data) {
    var bloc =  Bloc();
    bloc.lastHash = previous.hash;
    bloc.data = data;

    bloc.difficulty = previous.difficulty + adjusting;
    var nounce = 0;

    do {
      bloc.nounce = nounce ++;
      bloc.timestamp = DateTime.now();
      bloc.hash = calculateHash(bloc);
    } while(!validGoldenHash(bloc));

    return bloc;
  }

  String calculateHash(Bloc bloc) {
    var check = '${bloc.lastHash} ${bloc.timestamp} ${bloc.data} ${bloc.difficulty} ${bloc.nounce}';
    return sha256.convert(check.codeUnits).toString();
  }

  bool valid(Bloc bloc) {
    return calculateHash(bloc) == bloc.hash;
  }

  bool validGoldenHash(Bloc bloc) {
    var bin = bloc.hash.codeUnits.map((int strInt) => strInt.toRadixString(2)).join('');
    return bin.endsWith(List.filled(bloc.difficulty, '0').join(''));
  }
}
