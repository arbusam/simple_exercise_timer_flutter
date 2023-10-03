import 'package:flutter/material.dart';
import 'package:simple_exercise_timer/models/constants.dart';
import 'package:simple_exercise_timer/models/variables.dart';
import 'package:sqflite/sqflite.dart';
import 'workout_screen.dart';
import '../picker.dart';
import 'settings_screen.dart';
import 'history_screen.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  @override
  void initState() {
    super.initState();
  }

  void addToHistory() async {
    final Database db = await openDatabase(databasePath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE history(activity INTEGER, rest INTEGER, sets INTEGER, reps INTEGER)');
    });

    try {
      final List<Map<String, dynamic>> existingRows = await db.rawQuery(
        'SELECT * FROM history WHERE activity = ? AND rest = ? AND sets = ? AND reps = ?',
        [
          getData()['Activity']! + 1,
          getData()['Rest']! + 1,
          getData()['Sets']! + 1,
          getData()['Reps']! + 1,
        ],
      );

      if (existingRows.isNotEmpty) {
        await db.rawDelete(
          'DELETE FROM history WHERE activity = ? AND rest = ? AND sets = ? AND reps = ?',
          [
            getData()['Activity']! + 1,
            getData()['Rest']! + 1,
            getData()['Sets']! + 1,
            getData()['Reps']! + 1,
          ],
        );
      }

      await db.rawInsert(
        'INSERT INTO history(activity, rest, sets, reps) VALUES(?, ?, ?, ?)',
        [
          getData()['Activity']! + 1,
          getData()['Rest']! + 1,
          getData()['Sets']! + 1,
          getData()['Reps']! + 1,
        ],
      );
    } catch (e) {
      print(e);
    }
  }

  var activity = getData()['Activity']! + 1;
  var rest = getData()['Rest']! + 1;
  var sets = getData()['Sets']! + 1;
  var reps = getData()['Reps']! + 1;

  Widget buildGraph() {
    final totalActivity = activity * reps * sets;
    final totalRest = (rest * reps * sets) - rest;

    final activityMinutes = totalActivity ~/ 60;
    final activityRemainingSeconds = totalActivity % 60;
    final totalActivityString =
        "${activityMinutes.toString().padLeft(2, '0')}:${activityRemainingSeconds.toString().padLeft(2, '0')}";

    final restMinutes = totalRest ~/ 60;
    final restRemainingSeconds = totalRest % 60;
    final totalRestString =
        "${restMinutes.toString().padLeft(2, '0')}:${restRemainingSeconds.toString().padLeft(2, '0')}";

    final totalWorkoutLength = totalActivity + totalRest;
    final totalWorkoutLengthMinutes = totalWorkoutLength ~/ 60;
    final totalWorkoutLengthRemainingSeconds = totalWorkoutLength % 60;
    final totalWorkoutLengthString =
        "${totalWorkoutLengthMinutes.toString().padLeft(2, '0')}:${totalWorkoutLengthRemainingSeconds.toString().padLeft(2, '0')}";

    return Card(
      child: SizedBox(
        height: 150,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Total Workout Length: $totalWorkoutLengthString",
              style: TextStyle(fontSize: 26, fontFamily: 'Roboto-Medium'),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: totalActivity,
                    child: Stack(
                      children: [
                        Container(color: greenColor),
                        totalActivity / totalWorkoutLength < 0.3
                            ? Center()
                            : Center(
                                child: Text(
                                  "Activity: $totalActivityString",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Roboto-Medium',
                                      color: Colors.white),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: totalRest,
                    child: Stack(
                      children: [
                        Container(color: redColor),
                        totalRest / totalWorkoutLength < 1 / 4
                            ? Center()
                            : Center(
                                child: Text(
                                  "Rest: $totalRestString",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Roboto-Medium',
                                      color: Colors.white),
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HistoryScreen();
                  },
                ),
              );
            },
            icon: Icon(Icons.history)),
        actions: <Widget>[
          IconButton(
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
            icon: Icon(
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
              height: 137.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    SetupPicker(
                      title: 'Activity',
                      onChanged: (newValue) {
                        setState(() {
                          activity = newValue;
                        });
                      },
                    ),
                    SetupPicker(
                      title: 'Rest',
                      onChanged: (newValue) {
                        setState(() {
                          rest = newValue;
                        });
                      },
                    ),
                    SetupPicker(
                      title: 'Sets',
                      onChanged: (newValue) {
                        setState(() {
                          sets = newValue;
                        });
                      },
                    ),
                    SetupPicker(
                      title: 'Reps',
                      onChanged: (newValue) {
                        setState(() {
                          reps = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            buildGraph(),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        addToHistory();
                        return WorkoutScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  "Let's Start!",
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.labelLarge!.color,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
