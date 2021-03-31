class Log {
  String _name;
  int _kcal;

  Log(this._name, this._kcal);

  int get kcal => _kcal;

  set kcal(int value) {
    _kcal = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
