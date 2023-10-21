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
            ),
        iconTheme: IconThemeData(
          color: Color(0xFF212121),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              // Track color when the switch is selected.
              if (states.contains(MaterialState.selected)) {
                return Colors.white;
              }
              // Otherwise return null to set default track color
              // for remaining states such as when the switch is
              // hovered, focused, or disabled.
              return Color(0xFF79747E);
            },
          ),
          trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              // Track color when the switch is selected.
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.primary;
              }
              // Otherwise return null to set default track color
              // for remaining states such as when the switch is
              // hovered, focused, or disabled.
              return Color(0xFFE6E0E9);
            },
          ),
          trackOutlineColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              // Track color when the switch is selected.
              if (states.contains(MaterialState.selected)) {
                return null;
              }
              // Otherwise return null to set default track color
              // for remaining states such as when the switch is
              // hovered, focused, or disabled.
              return Color(0xFF79747E);
            },
          ),
        ),
      ),
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
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              // Track color when the switch is selected.
              if (states.contains(MaterialState.selected)) {
                return Colors.white;
              }
              // Otherwise return null to set default track color
              // for remaining states such as when the switch is
              // hovered, focused, or disabled.
              return Color(0xFF938F99);
            },
          ),
          trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              // Track color when the switch is selected.
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.primary;
              }
              // Otherwise return null to set default track color
              // for remaining states such as when the switch is
              // hovered, focused, or disabled.
              return null;
            },
          ),
          trackOutlineColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              // Track color when the switch is selected.
              if (states.contains(MaterialState.selected)) {
                return null;
              }
              // Otherwise return null to set default track color
              // for remaining states such as when the switch is
              // hovered, focused, or disabled.
              return Color(0xFF938F99);
            },
          ),
        ),
      ),
      home: (LoadingScreen()),
    );
  }
}
