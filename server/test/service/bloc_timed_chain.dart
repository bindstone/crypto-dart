import 'package:server/model/bloc_chain.dart';
import 'package:server/service/bloc_chain_service.dart';
import 'package:test/test.dart';

void main() {
  var blocChainService = BocChainService(null);

  test('valid Genesis', () {
    var chain = BlocChain();
    for(var i=0; i < 100; i++) {
      var bloc = blocChainService.addData(chain, 'Test run with line ${i}');
      print('${DateTime.now()} : data[${bloc.data}] difficulty[${bloc.difficulty}] nounce[${bloc.nounce}] ');
    }
  });

}