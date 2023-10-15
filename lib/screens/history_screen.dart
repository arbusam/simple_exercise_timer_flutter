import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_exercise_timer/models/constants.dart';
import 'package:simple_exercise_timer/models/methods.dart';
import 'package:simple_exercise_timer/models/variables.dart';
import 'package:simple_exercise_timer/screens/workout_screen.dart';
import 'dart:io' show Platform;
import 'package:sqflite/sqflite.dart';

class _HistoryScreenState extends State<HistoryScreen> {
  Future<List<Map<String, int>>?> getHistory() async {
    final Database db = await openDatabase(databasePath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE history(activity INTEGER, rest INTEGER, sets INTEGER, reps INTEGER)');
    });
    try {
      List<Map<String, dynamic>> list =
          await db.rawQuery('SELECT * FROM history');
      List<Map<String, int>> result = [];
      for (Map<String, dynamic> item in list) {
        result.add({
          'activity': item['activity'] as int,
          'rest': item['rest'] as int,
          'sets': item['sets'] as int,
          'reps': item['reps'] as int,
        });
      }
      return result;
    } on DatabaseException catch (e) {
      return null;
    }
  }

  Future<void> deleteHistory(int activity, int rest, int sets, int reps) async {
    final Database db = await openDatabase(databasePath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE history(activity INTEGER, rest INTEGER, sets INTEGER, reps INTEGER)');
    });
    try {
      await db.rawDelete(
        'DELETE FROM history WHERE activity = ? AND rest = ? AND sets = ? AND reps = ?',
        [
          activity,
          rest,
          sets,
          reps,
        ],
      );
    } on DatabaseException catch (e) {
      return null;
    }
  }

  var selectedTiles = <int>[];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading icon while the history is being fetched
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "History",
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.bodyLarge?.color),
              ),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle any errors that occurred while fetching the history
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "History",
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.bodyLarge?.color),
              ),
            ),
            body: Center(
              child: Text(
                'History could not be fetched',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        } else if (snapshot.hasData &&
            (snapshot.data! as List<Map<String, int>>).isNotEmpty) {
          List<Map<String, int>> data =
              snapshot.data! as List<Map<String, int>>;
          // Display the history if it was successfully fetched
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "History",
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.bodyLarge?.color),
              ),
              actions: [
                selectedTiles.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => Platform.isIOS
                                ? CupertinoAlertDialog(
                                    title: Text('Delete Workout'),
                                    content: Text(
                                        'Do you wish to delete these workouts?'),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text('No'),
                                        isDefaultAction: true,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: Text('Yes'),
                                        isDestructiveAction: true,
                                        onPressed: () {
                                          setState(() {
                                            for (int index in selectedTiles) {
                                              deleteHistory(
                                                data[index]['activity']!,
                                                data[index]['rest']!,
                                                data[index]['sets']!,
                                                data[index]['reps']!,
                                              );
                                            }
                                            selectedTiles.clear();
                                            Navigator.of(context).pop();
                                          });
                                        },
                                      ),
                                    ],
                                  )
                                : AlertDialog(
                                    title: Text('Delete Workout'),
                                    content: Text(
                                        'Do you wish to delete these workouts?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("No"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            for (int index in selectedTiles) {
                                              deleteHistory(
                                                data[index]['activity']!,
                                                data[index]['rest']!,
                                                data[index]['sets']!,
                                                data[index]['reps']!,
                                              );
                                            }
                                            selectedTiles.clear();
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: Text("Yes"),
                                      )
                                    ],
                                  ),
                          );
                        },
                      )
                    : Container()
              ],
            ),
            body: ListView.separated(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final totalActivity = (data[index]['activity'] as int) *
                    (data[index]['reps'] as int) *
                    (data[index]['sets'] as int);

                final totalRest = ((data[index]['rest'] as int) *
                        (data[index]['reps'] as int) *
                        (data[index]['sets'] as int)) -
                    data[index]['rest']!;

                final totalWorkoutLength = totalActivity + totalRest;
                final totalWorkoutLengthMinutes = totalWorkoutLength ~/ 60;
                final totalWorkoutLengthRemainingSeconds =
                    totalWorkoutLength % 60;
                final totalWorkoutLengthString =
                    "${totalWorkoutLengthMinutes.toString().padLeft(2, '0')}m:${totalWorkoutLengthRemainingSeconds.toString().padLeft(2, '0')}s";

                return ListTile(
                  title: Text('$totalWorkoutLengthString workout'),
                  leading: selectedTiles.isNotEmpty
                      ? selectedTiles.contains(index)
                          ? Icon(Icons.check_box)
                          : Icon(Icons.check_box_outline_blank)
                      : null,
                  onTap: () {
                    if (selectedTiles.isNotEmpty) {
                      setState(() {
                        if (selectedTiles.contains(index)) {
                          selectedTiles.remove(index);
                        } else {
                          selectedTiles.add(index);
                        }
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => Platform.isIOS
                            ? CupertinoAlertDialog(
                                title: Text('Redo Workout'),
                                content: Text(
                                    'Do you wish to redo this workout? Activity: ${data[index]["activity"]}, Rest: ${data[index]["rest"]}, Sets: ${data[index]["sets"]}, Reps: ${data[index]["reps"]}'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('No'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text('Yes'),
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      redoWorkout(context, data, index);
                                    },
                                  ),
                                ],
                              )
                            : AlertDialog(
                                title: Text('Redo Workout'),
                                content: Text(
                                    'Do you wish to redo this workout? Activity: ${data[index]["activity"]}, Rest: ${data[index]["rest"]}, Sets: ${data[index]["sets"]}, Reps: ${data[index]["reps"]}'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      redoWorkout(context, data, index);
                                    },
                                    child: Text("Yes"),
                                  )
                                ],
                              ),
                      );
                    }
                  },
                  onLongPress: () {
                    setState(() {
                      selectedTiles.add(index);
                    });
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          );
        } else {
          // Display a message if the history is empty
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(
                'No history',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        }
      },
    );
  }

  void redoWorkout(
      BuildContext context, List<Map<String, int>> data, int index) {
    addData('Activity', data[index]['activity']! - 1);
    valueUpdated('Activity', data[index]['activity']! - 1);
    addData('Rest', data[index]['rest']! - 1);
    valueUpdated('Rest', data[index]['rest']! - 1);
    addData('Sets', data[index]['sets']! - 1);
    valueUpdated('Sets', data[index]['sets']! - 1);
    addData('Reps', data[index]['reps']! - 1);
    valueUpdated('Reps', data[index]['reps']! - 1);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WorkoutScreen();
    }));
  }
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  State<HistoryScreen> createState() => _HistoryScreenState();
}
