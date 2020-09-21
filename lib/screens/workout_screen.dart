import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:simple_exercise_timer/models/constants.dart';
import 'dart:io';
import 'package:simple_exercise_timer/models/variables.dart';

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final int activity = getData()['Activity'] + 1;
  final int rest = getData()['Rest'] + 1;
  final int sets = getData()['Sets'] + 1;
  final int reps = getData()['Reps'] + 1;

  final player = AudioCache();

  bool paused = false;

  Color currentColour = greenColor;
  Color darkCurrentColour = darkGreenColour;

  int currentNumber = 3;
  int currentSets = 0;
  int currentReps = 0;

  String labelNumber = '3';

  String message = 'Wait';

  double progressNumber = 0;

  bool stop = true;

  void startTimer() {
    stop = false;
    player.play('sound1.mp3');
    activateTimer();
  }

  void activateTimer() {
    Timer(
      Duration(seconds: 1),
      callback,
    );
  }

  void activateActivityTimer() {
    Timer(
      Duration(seconds: 1),
      activityCallback,
    );
  }

  void activateRestTimer() {
    Timer(
      Duration(seconds: 1),
      restCallback,
    );
  }

  void callback() {
    if (stop != true) {
      setState(() {
        currentNumber -= 1;
        labelNumber = currentNumber.toString();
        progressNumber += 1 / 3;
      });
      if (currentNumber == 2) {
        player.play('sound1.mp3');
      } else if (currentNumber == 1) {
        player.play('sound1.mp3');
      }
      if (currentNumber == 0) {
        player.play('sound2.mp3');
        message = 'Go!';
        labelNumber = 'Go!';
      }
      if (currentNumber == -1) {
        currentNumber = activity;
        labelNumber = currentNumber.toString();
        progressNumber = 0;
        activateActivityTimer();
      } else {
        activateTimer();
      }
    }
  }

  void activityCallback() {
    if (stop != true) {
      setState(() {
        currentNumber -= 1;
        labelNumber = currentNumber.toString();
        progressNumber += 1 / activity;
      });
      if (currentNumber == 3) {
        player.play('sound1.mp3');
      } else if (currentNumber == 2) {
        player.play('sound1.mp3');
      } else if (currentNumber == 1) {
        player.play('sound1.mp3');
      }
      if (currentNumber == 0) {
        player.play('sound2.mp3');
        setState(() {
          currentColour = redColor;
          darkCurrentColour = darkRedColour;
          labelNumber = 'Rest';
        });
      }
      if (currentNumber != -1) {
        activateActivityTimer();
      } else {
        setState(() {
          currentReps += 1;
        });
        if (currentReps != reps) {
          setState(() {
            currentNumber = rest;
            labelNumber = currentNumber.toString();
            progressNumber = 0;
            message = 'Rest';
          });
          activateRestTimer();
        } else {
          setState(() {
            currentSets += 1;
          });
          if (currentSets != sets) {
            setState(() {
              currentNumber = rest;
              currentReps = 0;
              labelNumber = currentNumber.toString();
              progressNumber = 0;
              message = 'Rest';
            });
            activateRestTimer();
          } else {
            stop = true;
            setState(() {
              labelNumber = 'Done!';
              progressNumber = 1;
              message = 'Done!';
            });
          }
        }
      }
    }
  }

  void restCallback() {
    if (stop != true) {
      setState(() {
        currentNumber -= 1;
        labelNumber = currentNumber.toString();
        progressNumber += 1 / rest;
      });
      if (currentNumber == 3) {
        player.play('sound1.mp3');
      } else if (currentNumber == 2) {
        player.play('sound1.mp3');
      } else if (currentNumber == 1) {
        player.play('sound1.mp3');
      }
      if (currentNumber == 0) {
        player.play('sound2.mp3');
        setState(() {
          currentColour = greenColor;
          darkCurrentColour = darkGreenColour;
          labelNumber = 'Go!';
        });
      }
      if (currentNumber != -1) {
        activateRestTimer();
      } else {
        setState(() {
          currentNumber = activity;
          labelNumber = currentNumber.toString();
          progressNumber = 0;
          message = 'Activity';
        });
        activateActivityTimer();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void resetButton() {
    setState(() {
      paused = !paused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(message),
        leading: FlatButton(
          child: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            stop = true;
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? darkCurrentColour
            : currentColour,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Reps: $currentReps/$reps',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                    Text(
                      'Sets: $currentSets/$sets',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        height: ((MediaQuery.of(context).size.height) / 4),
                        width: ((MediaQuery.of(context).size.height) / 4),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              MediaQuery.of(context).platformBrightness ==
                                      Brightness.dark
                                  ? Colors.blueAccent
                                  : Colors.blue),
                          strokeWidth: 15.0,
                          value: progressNumber.toDouble(),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      Text(
                        '$labelNumber',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: 'NotoSans-Bold',
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  FlatButton(
                    onPressed: () {
                      resetButton();
                      if (stop == true) {
                        stop = false;
                        if (message == 'Go!') {
                          activateActivityTimer();
                        } else if (message == 'Rest') {
                          activateRestTimer();
                        }
                      } else {
                        stop = true;
                      }
                    },
                    child: Icon(
                      paused ? Icons.play_arrow : Icons.pause,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Container(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
