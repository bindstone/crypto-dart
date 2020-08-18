import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/config/application_config.dart';
import 'package:server/config/handler_config.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;

void main(List<String> arguments) async {

  var configFile = arguments.isNotEmpty ? arguments.first : './bin/config.yaml';

  var config = ApplicationConfiguration(configFile);

  var mongo =  Db('mongodb://${config.mongo.host}:${config.mongo.port}/${config.mongo.db}');

  await mongo.open();

  var handlerConfig = HandlerConfig(mongo);

  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addHandler(handlerConfig.handler);

  var server = await io.serve(handler, config.server.host, config.server.port);

  server.autoCompress = true;

  print('Serving     : http://${server.address.host}:${server.port}');
  print('Mongo-Admin : http://${server.address.host}:8081');
}