import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/config/handler_config.dart';
import 'package:server/service/bloc_chain_service.dart';
import 'package:shelf/shelf.dart';

class BlocChainHandler {
  Db _mongo;
  var blocChainService;

  BlocChainHandler(Db this._mongo) {
    blocChainService = BocChainService(_mongo);
  }

  Future<Response> handleRoute(Request request) async {
    var path = request.url.path.substring('api/bloc-chain'.length);
    if (request.method == 'GET') {
      var params = path.split('/');
      if (params[1].isEmpty) {
        var chain = await blocChainService.getBlocChain();
        return Response.ok(jsonEncode(chain), headers: REST_HEADER);
      } else {}
    }
    return Response.ok('Bloc Chain handled');
  }
}
