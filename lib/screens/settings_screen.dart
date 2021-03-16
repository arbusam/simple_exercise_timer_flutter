import 'package:flutter/material.dart';
import 'add_account_screen.dart';
import 'package:simple_exercise_timer/switch.dart';
import 'dart:io' show Platform;

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          children: Platform.isIOS
              ? <Widget>[
                  ListTile(title: Text('Mute'), trailing: (SettingsSwitch())),
                ]
              : <Widget>[
                  ListTile(title: Text('Mute'), trailing: (SettingsSwitch())),
                  ListTile(
                    title: Text('Health'),
                    leading: Image(
                      image: AssetImage('assets/Icon - Apple Health.png'),
                    ),
                  )
                ],
        ),
      ),
    );
  }
}
