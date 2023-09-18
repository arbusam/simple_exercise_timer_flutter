import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          colorScheme: ThemeData.light().colorScheme.copyWith(
                primary: Color(0xFF03A9F4),
                secondary: Color(0xFFFF5252),
                background: Colors.white,
              )),
      darkTheme: ThemeData.dark().copyWith(
        primaryTextTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Color(0xFF212121),
          ),
        ),
        colorScheme: ThemeData.dark().colorScheme.copyWith(
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
