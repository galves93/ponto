import 'dart:convert';

class JsonRead {
  var jsonDecode;

  dynamic usuario() {
    jsonDecode = '''
            [
              {
              "login":"gus",
              "senha":"1",
              "nome":"gustavo"
              },
              {
              "login":"b1",
              "senha":"2",
              "nome":"bruno"
              }
            ]''';
    return json.decode(jsonDecode);
  }
}
