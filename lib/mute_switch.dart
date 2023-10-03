import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_exercise_timer/models/methods.dart';
import 'package:simple_exercise_timer/models/variables.dart';
import 'dart:io' show Platform;

class MuteSwitch extends StatefulWidget {
  @override
  _MuteSwitchState createState() => _MuteSwitchState();
}

class _MuteSwitchState extends State<MuteSwitch> {
  CupertinoSwitch iOSSwitch() {
    return CupertinoSwitch(
      value: getMuteData(),
      onChanged: (bool value) {
        setState(() {
          muteValueUpdated(value);
          getMuteValue();
        });
      },
    );
  }

  Switch androidSwitch() {
    return Switch(
      value: getMuteData(),
      onChanged: (bool value) {
        setState(() {
          muteValueUpdated(value);
          getMuteValue();
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? iOSSwitch() : androidSwitch();
  }
}
