import 'package:flutter/material.dart';
import 'package:vr_ponto/global.dart';
import 'package:vr_ponto/splashScreen.dart';
import 'provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    gProviderNotifier = ProviderNotifier();
    return MaterialApp(
      localizationsDelegates: [
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionHandleColor: Colors.blue,
        cursorColor: Colors.blue,
        fontFamily: 'Arial',
        brightness: Brightness.dark,
        accentColor: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
