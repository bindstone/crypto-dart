import 'package:dart_amqp/dart_amqp.dart';

void main(List<String> arguments) async {

  // You can provide a settings object to override the
  // default connection settings
  var settings = ConnectionSettings(
      host : 'localhost',
      authProvider : PlainAuthenticator('guest', 'guest')
  );
  var client = Client(settings : settings);
  var result = client
      .channel()
      .then((Channel channel) => channel.queue('hello'))
      .then((Queue queue) => queue.publish('Hello World'))
      .whenComplete(() => print('sent'));
  // We dont care about the routing key as our exchange type is FANOUT
  print('End.');
  return client.close();
}
