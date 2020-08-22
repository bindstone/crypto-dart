import 'package:dart_amqp/dart_amqp.dart';

void main(List<String> arguments) async {

  var client = Client();

  var result = client
      .channel() // auto-connect to localhost:5672 using guest credentials
      .then((Channel channel) => channel.queue('hello'))
      .then((Queue queue) => queue.consume())
      .then((Consumer consumer) => consumer.listen((AmqpMessage message) {
    // Get the payload as a string
    print(' [x] Received string: ${message.payloadAsString}');

    // Or unserialize to json
    print(' [x] Received json: ${message.payloadAsJson}');

    // Or just get the raw data as a Uint8List
    print(' [x] Received raw: ${message.payload}');

    // The message object contains helper methods for
    // replying, ack-ing and rejecting
    message.reply('world');
  }));
  print('End.');
}
