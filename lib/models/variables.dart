Map<String, int> _data = {'Activity': 0, 'Rest': 0, 'Sets': 0, 'Reps': 0};

bool _mute = false;

void addData(String key, int newData) {
  _data[key] = newData;
}

void addMuteData(bool newData) {
  _mute = newData;
}

Map<String, int> getData() {
  return _data;
}

bool getMuteData() {
  return _mute;
}
