import 'package:flutter/material.dart';
import 'package:vr_ponto/global.dart';
import 'package:vr_ponto/login/UsuarioVO.dart';
import 'package:vr_ponto/tools.dart';
import '../detalhado/detalhadoUI.dart';
import '../format.dart';
import '../login/loginUI.dart';
import 'codigo_gerente.dart';

class HomeUI extends StatefulWidget {
  final UsuarioLogadoVO usuarioVO;

  const HomeUI({Key key, this.usuarioVO}) : super(key: key);
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> with SingleTickerProviderStateMixin {
  AnimationController _animController;
  Animation _animSaldo;

  @override
  void initState() {
    _animController =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _animSaldo = Tween<double>(begin: 0, end: -21.2).animate(CurvedAnimation(
      parent: _animController,
      curve: Interval(0, 1, curve: Curves.easeInOut),
    ));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Drawer _drawer = Drawer(
        child: Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.orangeAccent,
                    Colors.orange,
                  ])),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "${widget.usuarioVO.nome.toUpperCase()}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.035,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.usuarioVO.gerente == 0
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading:
                                Icon(Icons.exit_to_app, color: Colors.grey),
                            title: Text("Sair",
                                style: TextStyle(color: Colors.grey)),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginUI(),
                                  ));
                            },
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Icon(Icons.account_circle_outlined,
                                    color: Colors.grey),
                                title: Text("Código de gerente",
                                    style: TextStyle(color: Colors.grey)),
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CodigoGerente(
                                          usuarioVO: widget.usuarioVO,
                                        ),
                                      ));
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Icon(Icons.exit_to_app,
                                      color: Colors.grey),
                                  title: Text("Sair",
                                      style: TextStyle(color: Colors.grey)),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginUI(),
                                        ));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0 * 2),
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Versão: 0.1",
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              )),
        ],
      ),
    ));

    double _sizeSaldo = 70.0;
    _animController.forward();

    return WillPopScope(
      onWillPop: () => Tools().goTo(context, LoginUI()),
      child: Scaffold(
        appBar: gappBar,
        drawer: _drawer,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(gpadding),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(gcircularRadius),
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(gpadding),
                          child: Center(
                            child: Text('Saldo Banco de Horas',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                          animation: _animController,
                          builder: (BuildContext context, Widget child) {
                            return Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(gpadding),
                                child: Center(
                                  child: Text(
                                      Format().decimal2(_animSaldo.value),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: _sizeSaldo)),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(gpadding),
                child: GestureDetector(
                  onTap: () {
                    Tools().goTo(
                        context,
                        DetalhadoUI(
                          usuarioVO: widget.usuarioVO,
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(gcircularRadius),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(gpadding),
                          child: Container(
                            child: Text('Analisar Ponto Detalhado',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          size: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
