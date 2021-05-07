import 'dart:convert';

class JsonRead {
  var jsonDecode;

  dynamic usuario() {
    jsonDecode = '''
            [
              {
              "login":"gus",
              "senha":"1",
              "nome":"gustavo",
              "chaveGerente": "123AbC456dEf",
              "gerente": true
              },
              {
              "login":"b1",
              "senha":"2",
              "nome":"bruno",
              "chaveGerente": "123AbC456dEf",
              "gerente": false
              }
            ]''';
    return json.decode(jsonDecode);
  }

  // dynamic
}
