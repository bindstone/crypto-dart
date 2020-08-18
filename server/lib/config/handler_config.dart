import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/web_handler/bloc_handler.dart';
import 'package:shelf/shelf.dart';

class HandlerConfig {
  var handler;
  var blocHandler;

  HandlerConfig(Db mongo) {
    blocHandler = BlocHandler(mongo);
    handler = Cascade()
        .add((request) {
          if (request.url.path == 'bloc') {
            return blocHandler.handleRoute(request);
          }
          return Response.notFound('');
        })
        .add((request) =>
            Response.notFound('No route handler for: ' + request.url.path))
        .handler;
  }
}
