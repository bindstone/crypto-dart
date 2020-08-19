
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';

class BlocHandler {

  Db _mongo;
  BlocHandler(this._mongo);

  Response handleRoute(Request request) {
    var path = request.url.path.substring('api/bloc'.length);
    if (request.method == 'GET') {
      var params = path.split('/');
      if (params.length == 1 || params[1].isEmpty) {

      } else {

      }
    }
    return Response.ok('Bloc handled');
  }


}