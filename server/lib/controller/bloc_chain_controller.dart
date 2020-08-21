import 'dart:convert';
import 'dart:io';

import 'package:http_server/http_server.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/config/handler_config.dart';
import 'package:server/service/bloc_chain_service.dart';
import 'package:shelf/shelf.dart';

class BlocChainController {

  var blocChainService;

  BlocChainController(Db _mongo) {
    blocChainService = BocChainService(_mongo);
  }

  void handleRoute(HttpRequestBody rqBody) async {
    var request = rqBody.request;
    var path = request.uri.path.substring('/api/bloc-chain'.length);

    if (request.method == 'GET') {
      var params = path.split('/');
      if (params[1].isEmpty) {
        var chain = await blocChainService.getBlocChain();
        addRestHeaders(request.response.headers);
        await request.response.write(jsonEncode(chain));
        await request.response.close();
      } else {
        request.response.statusCode = 405;
        await request.response.close();
      }
    }
  }

}
