import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

final dio = Dio();

class MarcarPontoDAO {
  Future setMarcarPonto(int idUsuario) async {
    var cliente = http.Client();
    var response;
    var url = Uri.parse('http://192.168.56.1:9000/setdatahora');

    try {
      response = await cliente.post(url,
          body: json.encode({
            'id': idUsuario,
          }),
          headers: {
            'accept': 'application/json',
            'content-type': 'application/json'
          });
    } finally {
      print(response.body);
      cliente.close();
    }

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Ponto registrado",
        backgroundColor: Colors.green,
      );
      return true;
    } else {
      return false;
    }
  }
}
