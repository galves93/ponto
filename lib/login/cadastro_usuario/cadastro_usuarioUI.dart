import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toast/toast.dart';
import 'package:vr_ponto/login/cadastro_usuario/cadastro_usuarioDAO.dart';
import 'package:vr_ponto/login/loginUI.dart';
import 'package:vr_ponto/tools.dart';

import 'novo_cadastro_usuarioUI.dart';

class CadastroUsuarioUI extends StatefulWidget {
  @override
  _CadastroUsuarioUIState createState() => _CadastroUsuarioUIState();
}

class _CadastroUsuarioUIState extends State<CadastroUsuarioUI> {
  TextEditingController chaveController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Tools().goTo(context, LoginUI()),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Coloque aqui o código do gerente para que possamos validar seu cadastro"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: chaveController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () async {
                  if (chaveController.text.isNotEmpty) {
                    bool isPermission = await CadastroUsuarioDAO()
                        .getChaveGerente(chaveController.text);
                    if (isPermission) {
                      Tools().goTo(context, NovoCadastroUsuarioUI());
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Erro ao validar chave',
                          backgroundColor: Colors.red,
                          textColor: Colors.white);
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Campo não pode ser vazio',
                        backgroundColor: Colors.red,
                        textColor: Colors.white);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Continuar",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                color: Colors.orange,
              ),
            )
          ],
        ),
      ),
    );
  }
}
