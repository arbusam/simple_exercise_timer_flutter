import 'package:shared_preferences/shared_preferences.dart';
import 'variables.dart';

void valueUpdated(String key, int value) async {
  // obtain shared preferences
  final prefs = await SharedPreferences.getInstance();

  // set value
  prefs.setInt(key, value);
}

Future<void> getValues() async {
  final prefs = await SharedPreferences.getInstance();

  // Try reading data from the Activity, Rest, Sets and Reps keys. If it
  // doesn't exist, return 0.
  addData('Activity', prefs.getInt('Activity') ?? 0);
  addData('Rest', prefs.getInt('Rest') ?? 0);
  addData('Sets', prefs.getInt('Sets') ?? 0);
  addData('Reps', prefs.getInt('Reps') ?? 0);
}
