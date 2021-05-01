import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.orange, selectionHandleColor: Colors.orange),
        fontFamily: 'Arial',
        brightness: Brightness.dark,
        accentColor: Colors.orange,
      ),
      home: SplashScreen(),
    );
  }
}
