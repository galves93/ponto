import 'package:flutter_masked_text/flutter_masked_text.dart';

class Format {
  String decimal2(double valor) {
    var format = MoneyMaskedTextController(precision: 2);
    format.updateValue(valor);
    return format.text;
  }
}
