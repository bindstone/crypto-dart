import 'dart:io';

import 'package:safe_config/safe_config.dart';
import 'package:server/config/mongo_config.dart';
import 'package:server/config/server_config.dart';

class ApplicationConfiguration extends Configuration {

  ApplicationConfiguration(String fileName) :
        super.fromFile(File(fileName));

  ServerConfig server;
  MongoConfig mongo;

}
