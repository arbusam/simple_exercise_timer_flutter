import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          useMaterial3: true,
          primaryTextTheme: TextTheme(
            bodyLarge: TextStyle(
              color: Color(0xFF212121),
            ),
          ),
          colorScheme: ThemeData.light().colorScheme.copyWith(
                primary: Color(0xFF03A9F4),
                secondary: Color(0xFFFF5252),
                background: Colors.white,
              )),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        primaryTextTheme: TextTheme(
            bodyLarge: TextStyle(
              color: Color(0xFF212121),
            ),
            labelLarge: TextStyle(color: Colors.white)),
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Color(0xFF0288D1),
              secondary: Color(0xFFFF5252),
              background: Colors.black,
            ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: (LoadingScreen()),
    );
  }
}
