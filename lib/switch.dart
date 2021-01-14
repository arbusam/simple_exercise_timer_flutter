import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_exercise_timer/models/methods.dart';
import 'package:simple_exercise_timer/models/variables.dart';
import 'dart:io' show Platform;

class SettingsSwitch extends StatefulWidget {
  @override
  _SettingsSwitchState createState() => _SettingsSwitchState();
}

class _SettingsSwitchState extends State<SettingsSwitch> {
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
