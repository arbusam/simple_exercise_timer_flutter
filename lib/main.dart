import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF03A9F4),
        accentColor: Color(0xFFFF5252),
        backgroundColor: Colors.white,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryTextTheme: TextTheme(
          bodyText1: TextStyle(
            color: Color(0xFF212121),
          ),
        ),
        backgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
        ),
      ),
      home: (LoadingScreen()),
    );
  }
}
