import 'package:flutter/material.dart';
import 'package:simple_exercise_timer/mute_switch.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
          children: <Widget>[
            ListTile(title: Text('Mute'), trailing: (MuteSwitch())),
          ],
        ),
      ),
    );
  }
}
