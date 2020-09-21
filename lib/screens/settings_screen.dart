import 'package:flutter/material.dart';
import 'add_account_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Add Accounts'),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddAccountsScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
