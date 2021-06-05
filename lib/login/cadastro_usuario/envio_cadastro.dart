import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:vr_ponto/login/loginDAO.dart';

final dio = Dio();

class CadastroUsuario {
  Future<bool> setCliente(String login, String senha, String nome,
      String chaveGerente, bool gerente) async {
    var cliente = http.Client();
    var response;
    var url = Uri.parse('http://192.168.56.1:9000/setusuario');

    try {
      response = await cliente.post(url,
          body: json.encode({
            'login': login,
            'senha': senha,
            'nome': nome,
            'chavegerente': chaveGerente,
            'gerente': gerente
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
        msg: "Cadastrado",
        backgroundColor: Colors.green,
      );
      await LoginDAO().getUsuario();
      return true;
    } else {
      return false;
    }
  }
}
