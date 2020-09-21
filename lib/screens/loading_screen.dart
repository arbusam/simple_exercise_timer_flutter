import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_exercise_timer/models/methods.dart';
import 'setup_screen.dart';

class LoadingScreen extends StatelessWidget {
  void load(var context) async {
    await getValues();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SetupScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    load(context);
    return Container(
      color: Colors.white,
    );
  }
}
