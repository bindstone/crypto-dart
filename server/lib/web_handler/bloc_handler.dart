
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';

class BlocHandler {

  Db _mongo;
  BlocHandler(this._mongo);

  Response handleRoute(Request request) {
    return Response.ok('Bloc handled');
  }
}