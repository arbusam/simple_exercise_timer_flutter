import 'package:flutter/material.dart';
import 'workout_screen.dart';
import '../picker.dart';
import 'settings_screen.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsScreen();
                  },
                ),
              );
            },
            child: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 150.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    SetupPicker(title: 'Activity'),
                    SetupPicker(title: 'Rest'),
                    SetupPicker(title: 'Sets'),
                    SetupPicker(title: 'Reps'),
                  ],
                ),
              ),
            ),
            Container(
              height: ((MediaQuery.of(context).size.height) / 2) - 41,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 110.0,
                    width: 120.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFFFF5252),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return WorkoutScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Let's Start",
                        style: TextStyle(
                          color: Color(0xFF212121),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
