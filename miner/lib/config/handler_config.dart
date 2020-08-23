import 'dart:io';
/**
import 'package:http_server/http_server.dart';
import 'package:server/controller/bloc_chain_controller.dart';
import 'package:server/controller/bloc_controller.dart';

void addRestHeaders(HttpHeaders headers) {
  headers.add('Access-Control-Allow-Origin', '*');
  headers.add('Content-Type', 'application/json');
}

class HandlerConfig {

  Db _mongo;

  HandlerConfig(this._mongo);

  Future<void> handleRoute(HttpRequestBody _rqBody) async {
    var path = _rqBody.request.uri.path;
    print('Request for [${path}]');
    //
    if (path.startsWith('/api/bloc-chain')) {
      BlocChainController(_mongo).handleRoute(_rqBody);
    //
    } else if (path.startsWith('/api/bloc')) {
      BlocController(_mongo).handleRoute(_rqBody);
    //
    } else {
      _rqBody.request.response.statusCode = 405;
      await _rqBody.request.response.close();
    }
  }
}
**/