import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Stream<String> getChatResponse(String content) async* {
  final url = 'https://a.run.app/';
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer '
  };
  final body = json.encode({'content': content});

  var request = http.Request('POST', Uri.parse(url))
    ..headers.addAll(headers)
    ..body = body;

  var streamedResponse = await request.send();

  await for (var line in streamedResponse.stream
      .transform(utf8.decoder)
      .transform(const LineSplitter())) {
    for (var word in line.split(' ')) {
      await Future.delayed(Duration(milliseconds: 10));
      yield word + ' ';
    }
  }
}
