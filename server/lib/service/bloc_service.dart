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
    var check = '${bloc.data}${bloc.difficulty}${bloc.lastHash}${bloc.nounce}${bloc.timestamp}';
    return sha256.convert(check.codeUnits).toString();
  }

  bool valid(Bloc bloc) {
    return calculateHash(bloc) == bloc.hash;
  }

  bool validGoldenHash(Bloc bloc) {
    //  hash.split('').map((x) => int.parse(x, radix: 16).toRadixString(2).padLeft(8, '0')).join('');
    //  hash.codeUnits.map((x) => x.toRadixString(2).padLeft(8, '0')).join()
    var bin = bloc.hash.split('').map((x) => int.parse(x, radix: 16).toRadixString(2).padLeft(8, '0')).join('');
    return bin.startsWith(List.filled(bloc.difficulty, '0').join(''));
  }
}
