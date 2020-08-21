import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/config/application_config.dart';
import 'package:server/config/handler_config.dart';
import 'package:http_server/http_server.dart';

void main(List<String> arguments) async {
  var configFile = arguments.isNotEmpty ? arguments.first : './bin/config.yaml';

  var config = ApplicationConfiguration(configFile);

  var mongo = Db('mongodb://${config.mongo.host}:${config.mongo.port}/${config.mongo.db}');

  await mongo.open();

  var server = await HttpServer.bind(config.server.host, config.server.port);
  server.autoCompress = true;
  server.transform(HttpBodyHandler()).listen((HttpRequestBody rqBody) async {
    await HandlerConfig(mongo).handleRoute(rqBody);
  });

  print('Serving     : http://${server.address.host}:${server.port}');
  print('Mongo-Admin : http://${server.address.host}:8081');

  //await mongo.close();
  //await server.close();
  //print('Service closed.');
}
