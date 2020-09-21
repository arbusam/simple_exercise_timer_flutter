Map<String, int> _data = {'Activity': 0, 'Rest': 0, 'Sets': 0, 'Reps': 0};

void addData(String key, int newData) {
  _data[key] = newData;
}

Map<String, int> getData() {
  return _data;
}
