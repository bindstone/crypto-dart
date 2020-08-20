import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/web_handler/bloc_chain_handler.dart';
import 'package:server/web_handler/bloc_handler.dart';
import 'package:shelf/shelf.dart';

const REST_HEADER = {
  'Access-Control-Allow-Origin': '*',
  'Content-Type': 'application/json'
};

class HandlerConfig {
  var handler;

  HandlerConfig(Db mongo) {
    var blocHandler = BlocHandler(mongo);
    var blocChainHandler = BlocChainHandler(mongo);
    handler = Cascade().add((request) {
      if (request.url.path.startsWith('api/bloc-chain')) {
        return blocChainHandler.handleRoute(request);
      }
      if (request.url.path.startsWith('api/bloc')) {
        return blocHandler.handleRoute(request);
      }
      return Response.notFound('No route handler for: ' + request.url.path);
    }).handler;
  }
}
