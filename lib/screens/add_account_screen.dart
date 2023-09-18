import 'package:flutter/material.dart';
//import 'package:strava_flutter/strava.dart';
import 'package:simple_exercise_timer/secret.dart';

class AddAccountsScreen extends StatefulWidget {
  @override
  _AddAccountsScreenState createState() => _AddAccountsScreenState();
}

class _AddAccountsScreenState extends State<AddAccountsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: TextButton(
              onPressed: () {
                //final strava = Strava(true, secret);
              },
              child: Text('Strava'),
            ),
          )
        ],
      ),
    );
  }
}
