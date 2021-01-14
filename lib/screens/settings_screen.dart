import 'package:flutter/material.dart';
import 'add_account_screen.dart';
import 'package:simple_exercise_timer/switch.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          children: <Widget>[
            ListTile(title: Text('Mute'), trailing: (SettingsSwitch())),
          ],
        ),
      ),
    );
  }
}
