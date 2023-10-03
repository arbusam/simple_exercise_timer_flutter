import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_exercise_timer/models/constants.dart';
import 'dart:io' show Platform;
import 'package:sqflite/sqflite.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading icon while the history is being fetched
          return Text("Loading...");
        } else if (snapshot.hasError) {
          // Handle any errors that occurred while fetching the history
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData &&
            (snapshot.data! as List<Map<String, int>>).isNotEmpty) {
          List<Map<String, int>> data =
              snapshot.data! as List<Map<String, int>>;
          // Display the history if it was successfully fetched
          return Scaffold(
            appBar: AppBar(
              actions: [],
            ),
            body: ListView.separated(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(
                        'Activity: ${data[index]['activity']}, Rest: ${data[index]['rest']}, Sets: ${data[index]['sets']}, Reps: ${data[index]['reps']}'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Platform.isIOS
                            ? CupertinoAlertDialog(
                                title: Text('Redo Workout'),
                                content: Text(
                                    'Do you wish to redo this workout? Activity: 0, Rest: 0, Sets: 0, Reps: 0'),
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
                                    onPressed: () {},
                                  ),
                                ],
                              )
                            : AlertDialog(
                                title: Text('Redo Workout'),
                                content: Text(
                                    'Do you wish to redo this workout? Activity: 0, Rest: 0, Sets: 0, Reps: 0'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No"),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text("Yes"),
                                  )
                                ],
                              ),
                      );
                    });
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
}
