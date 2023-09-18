import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:simple_exercise_timer/models/constants.dart';
import 'dart:io';
import 'package:simple_exercise_timer/models/variables.dart';

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final int activity = (getData()['Activity'] ?? 0) + 1;
  final int rest = (getData()['Rest'] ?? 0) + 1;
  final int sets = (getData()['Sets'] ?? 0) + 1;
  final int reps = (getData()['Reps'] ?? 0) + 1;

  final player1 = AssetsAudioPlayer();
  final player2 = AssetsAudioPlayer();

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
    if (!getMuteData()) {
      player1.open(Audio('assets/sound1.mp3'));
    }
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
      if (currentNumber == 2 && !getMuteData()) {
        player1.open(Audio('assets/sound1.mp3'));
      }
      if (currentNumber == 1 && !getMuteData()) {
        player1.open(Audio('assets/sound1.mp3'));
      }
      if (currentNumber == 0) {
        if (!getMuteData()) {
          player1.open(Audio('assets/sound2.mp3'));
        }
        message = 'Activity';
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
      if (currentNumber == 3 && !getMuteData()) {
        player1.open(Audio('assets/sound1.mp3'));
      } else if (currentNumber == 2 && !getMuteData()) {
        player1.open(Audio('assets/sound1.mp3'));
      } else if (currentNumber == 1 && !getMuteData()) {
        player1.open(Audio('assets/sound1.mp3'));
      }
      if (currentNumber == 0) {
        if (!getMuteData()) {
          player1.open(Audio('assets/sound2.mp3'));
        }
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

              // if (_rateMyApp.shouldOpenDialog) {
              _rateMyApp.showStarRateDialog(context,
                  title: 'Enjoying '
                      'Simple Exercise Timer?',
                  dialogStyle: DialogStyle(
                    titleAlign: TextAlign.center,
                    messageAlign: TextAlign.center,
                    messagePadding: EdgeInsets.only(bottom: 20.0),
                  ), actionsBuilder: (context, stars) {
                return [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                      if (stars != null) {
                        _rateMyApp
                            .save()
                            .then((value) => Navigator.pop(context));

                        // if (stars <= 3) {
                        //   AlertDialog alertDialog = Platform.isIOS
                        //       ? CupertinoAlertDialog(
                        //           title: Text("Send Feedback?"),
                        //           content: Text(
                        //               "Do you want to send some feedback about my app?"),
                        //           actions: <Widget>[
                        //             TextButton(child: Text("Yes")),
                        //             TextButton(child: Text("No")),
                        //           ],
                        //         )
                        //       : AlertDialog(
                        //           title: Text("Send Feedback?"),
                        //           content: Text(
                        //               "Do you want to send some feedback about my app?"),
                        //           actions: <Widget>[
                        //             TextButton(child: Text("Yes")),
                        //             TextButton(child: Text("No")),
                        //           ],
                        //         );
                        //   showDialog(
                        //     context: context,
                        //     builder: (_) {
                        //       return alertDialog;
                        //     },
                        //   );
                        // }
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ];
              });
              // }
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
      if (currentNumber == 3 && !getMuteData()) {
        player1.open(Audio('assets/sound1.mp3'));
      } else if (currentNumber == 2 && !getMuteData()) {
        player1.open(Audio('assets/sound1.mp3'));
      } else if (currentNumber == 1 && !getMuteData()) {
        player1.open(Audio('assets/sound1.mp3'));
      }
      if (currentNumber == 0) {
        if (!getMuteData()) {
          player1.open(Audio('assets/sound2.mp3'));
        }
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
    // player1.open(Audio('assets/sound1.mp3')), volume: 0);
    // player2.open(Audio('assets/sound2.mp3')), volume: 0);
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    stop = true;
  }

  void resetButton() {
    setState(() {
      paused = !paused;
    });
  }

  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 5,
    minLaunches: 3,
    remindDays: 5,
    remindLaunches: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(message),
        leading: TextButton(
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
                  TextButton(
                    onPressed: () {
                      resetButton();
                      if (stop == true) {
                        stop = false;
                        if (message == 'Activity') {
                          activateActivityTimer();
                        } else if (message == 'Rest') {
                          activateRestTimer();
                        } else if (message == 'Wait') {
                          activateTimer();
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
