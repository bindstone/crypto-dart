import 'package:safe_config/safe_config.dart';

const COLLECTION_BLOC_CHAIN = 'BLOC_CHAIN';

class MongoConfig extends Configuration {
  String host;
  int port;
  String db;
}