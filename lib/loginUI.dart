import 'package:flutter/material.dart';
import 'package:vr_ponto/tools.dart';

import 'global.dart';
import 'home.dart';

class LoginUI extends StatefulWidget {
  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation animUser;
  Animation animPass;
  Animation animOpacity;
  Animation animButtonWidth;
  Animation animButtonCirc;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        duration: Duration(milliseconds: 5000), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    animController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    animUser = Tween<double>(begin: 0.0, end: 365.0).animate(CurvedAnimation(
        parent: animController,
        curve: Interval(0.0, 0.5, curve: Curves.bounceOut)));
    animPass = Tween<double>(begin: 0.0, end: 365.0).animate(CurvedAnimation(
        parent: animController,
        curve: Interval(0.0, 0.5, curve: Curves.bounceOut)));
    animOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: Interval(0.2, 0.6, curve: Curves.easeInOut),
        parent: animController));
    animButtonWidth = Tween<double>(begin: 300.0, end: 55.0).animate(
        CurvedAnimation(
            curve: Interval(0.0, 0.4, curve: Curves.bounceOut),
            parent: animController));
    animButtonCirc = Tween<double>(begin: 10.0, end: 40.0).animate(
        CurvedAnimation(
            curve: Interval(0.0, 0.4, curve: Curves.bounceOut),
            parent: animController));
  }

  void goRoute() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeUI()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: gappBar,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Container(
                      child: Center(
                        child: Icon(
                          Icons.access_alarm,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),
                      height: 150,
                      decoration: BoxDecoration(
                          color: gcorPrincipal,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80),
                              bottomRight: Radius.circular(80),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Matrícula',
                        hintText: 'Matrícula'),
                  ),
                ),
                AnimatedBuilder(
                  animation: animOpacity,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(
                        child: Text(
                      'Número de fornecedido pelo RH',
                      style: TextStyle(color: gcorPrincipal, fontSize: 14),
                    )),
                  ),
                  builder: (BuildContext context, Widget child) {
                    return Opacity(
                      opacity: animOpacity.value,
                      child: child,
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: animController,
                  builder: (BuildContext context, Widget child) {
                    return Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: MaterialButton(
                        child: Container(
                          decoration: BoxDecoration(
                              color: gcorPrincipal,
                              borderRadius:
                                  BorderRadius.circular(animButtonCirc.value)),
                          child: Center(
                              child: animController.value > 0
                                  ? CircularProgressIndicator()
                                  : Text(
                                      'ENTRAR',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    )),
                          height: 50,
                          width: animButtonWidth.value,
                        ),
                        onPressed: () {
                          if (animController.value > 0) {
                            animController.reverse();
                          } else
                            animController.forward();
                          Future.delayed(Duration(milliseconds: 3200),
                              () async {
                            Tools().goTo(context, HomeUI());
                          });
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
