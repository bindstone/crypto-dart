import 'package:http_server/http_server.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/service/wallet_service.dart';

class WalletController {

  WalletService _walletService;

  WalletController(Db _mongo) {
    _walletService = WalletService(_mongo);
  }

  void handleRoute(HttpRequestBody rqBody) async {
    var request = rqBody.request;
    var path = request.uri.path.substring('/api/Wallet'.length);

    if (request.method == 'GET') {
      request.response.statusCode = 405;
      await request.response.close();
    } else {
      request.response.statusCode = 405;
      await request.response.close();
    }
  }
}