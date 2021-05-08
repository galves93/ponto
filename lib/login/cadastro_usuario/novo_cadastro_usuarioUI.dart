import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vr_ponto/login/cadastro_usuario/cadastro_usuarioDAO.dart';
import 'package:vr_ponto/login/loginUI.dart';
import 'package:vr_ponto/tools.dart';

class NovoCadastroUsuarioUI extends StatefulWidget {
  final String chaveGerente;

  const NovoCadastroUsuarioUI({Key key, this.chaveGerente}) : super(key: key);
  @override
  _NovoCadastroUsuarioUIState createState() => _NovoCadastroUsuarioUIState();
}

class _NovoCadastroUsuarioUIState extends State<NovoCadastroUsuarioUI> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController sobrenomeController = TextEditingController();
  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmaSenhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CadastroUsuarioDAO cadastroDao = CadastroUsuarioDAO();
  bool isCadastrado;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Tools().goTo(context, LoginUI()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("CADASTRO"),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Tools().goTo(context, LoginUI());
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Sua chave para cadastro: \n",
                      style: TextStyle(fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.chaveGerente,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        )
                      ]),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nomeController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Nome",
                            hintText: "Nome"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: sobrenomeController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Sobrenome",
                            hintText: "Sobrenome"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: usuarioController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Usuario",
                            hintText: "Usuario"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Favor coloque uma senha";
                          }
                          return null;
                        },
                        controller: senhaController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Senha",
                            hintText: "Senha"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Favor confirme sua senha";
                          } else if (senhaController.text != value) {
                            return "Senhas diferentes, favor colocar a mesma senha";
                          }
                          return null;
                        },
                        controller: confirmaSenhaController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Confirmar Senha",
                            hintText: "Confirmar Senha"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: MaterialButton(
                        color: Colors.orange,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            isCadastrado = await cadastroDao.setNovoCadastro(
                              nomeController.text,
                              sobrenomeController.text,
                              usuarioController.text,
                              senhaController.text,
                              widget.chaveGerente,
                            );
                            if (isCadastrado) {
                              Fluttertoast.showToast(
                                msg: 'Cadastrado com sucesso!',
                                backgroundColor: Colors.green,
                              );
                              Tools().goTo(context, LoginUI());
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Usuario já utilizado',
                                backgroundColor: Colors.green,
                              );
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Cadastrar",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
