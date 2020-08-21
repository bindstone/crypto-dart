import 'dart:io';

import 'package:http_server/http_server.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/service/bloc_service.dart';

class BlocController {

  BlocService _blocService;

  BlocController(Db _mongo) {
    _blocService = BlocService(_mongo);
  }

  void handleRoute(HttpRequestBody rqBody) async {
    var request = rqBody.request;
    var path = request.uri.path.substring('/api/bloc'.length);

    if (request.method == 'GET') {
      request.response.statusCode = 405;
      await request.response.close();
    } else {
      request.response.statusCode = 405;
      await request.response.close();
    }
  }
}