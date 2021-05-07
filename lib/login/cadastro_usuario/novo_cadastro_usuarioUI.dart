import 'package:flutter/material.dart';
import 'package:vr_ponto/login/loginUI.dart';
import 'package:vr_ponto/tools.dart';

class NovoCadastroUsuarioUI extends StatefulWidget {
  @override
  _NovoCadastroUsuarioUIState createState() => _NovoCadastroUsuarioUIState();
}

class _NovoCadastroUsuarioUIState extends State<NovoCadastroUsuarioUI> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Tools().goTo(context, LoginUI()),
      child: Scaffold(
        body: Column(
          children: [
            //  FormField(builder: _),
          ],
        ),
      ),
    );
  }
}
